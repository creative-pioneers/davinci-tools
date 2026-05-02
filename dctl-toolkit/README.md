# DCTL Visualization Toolkit

On-set and in-grade visualization tools for footage shot in **Canon C-Log 3** on the **Canon R5C**, implemented as DCTL (DaVinci Color Transform Language) effects for DaVinci Resolve 18+.

All tools operate per-pixel on the GPU and are applied as node effects in the Color page.

## Installation

```bash
cd dctl-toolkit
chmod +x install.sh
./install.sh
```

This symlinks all `.dctl` files into Resolve's LUT directory, organized into subfolders. To remove:

```bash
./install.sh --uninstall
```

### Manual Installation

Copy or symlink the `.dctl` files to your Resolve LUT directory:

| Platform | Path |
|----------|------|
| macOS | `~/Library/Application Support/Blackmagic Design/DaVinci Resolve/LUT/` |
| Linux | `~/.local/share/DaVinciResolve/LUT/` |
| Windows | `%APPDATA%\Blackmagic Design\DaVinci Resolve\Support\LUT\` |

After copying, right-click in the DCTL picker and select **Update Lists**.

## Tools

### Transforms

#### `clog3_to_linear.dctl`
Converts Canon C-Log 3 signal to scene-linear light. Implements the full piecewise inverse of the Canon C-Log 3 transfer function including the linear segment near zero. Use as a utility node before other processing that expects linear input.

- **Input:** Canon C-Log 3 encoded
- **Output:** Scene-linear (same gamut as input)

#### `clog3_to_rec709.dctl`
Full pipeline from Canon C-Log 3 / Cinema Gamut to Rec.709 display. Applies C-Log 3 linearization, Cinema Gamut to Rec.709 3x3 matrix, and Rec.709 OETF. Use as a quick-look transform or starting point for grading.

- **Input:** Canon C-Log 3, Cinema Gamut
- **Output:** Rec.709 gamma-encoded

### Visualization

#### `false_color_clog3.dctl`
Maps luma to a false color exposure zone scheme tuned for C-Log 3 log values.

| Color | Zone | C-Log 3 IRE |
|-------|------|-------------|
| Purple | Crushed blacks | < 0.10 |
| Blue | Deep shadows | 0.10 - 0.25 |
| Teal | Shadow detail | 0.25 - 0.35 |
| Green | Middle grey (18%) | 0.35 - 0.43 |
| Grey | Upper midtones | 0.43 - 0.50 |
| Pink | Skin tones | 0.50 - 0.58 |
| Yellow | Highlights | 0.58 - 0.75 |
| Orange | Hot highlights | 0.75 - 0.95 |
| Red | Clipped | > 0.95 |

- **UI Params:** Input Mode (C-Log 3 / Rec.709 toggle)

#### `zebras.dctl`
Diagonal stripe overlay on clipped (overexposed) and crushed (underexposed) pixels. Red stripes for highlights exceeding the high threshold, blue stripes for shadows below the low threshold.

- **UI Params:** High Threshold (0.95), Low Threshold (0.02), Stripe Width, Base Desaturation

#### `focus_peaking.dctl`
Highlights in-focus edges using a 3x3 Laplacian kernel on the luma channel. Pixels where the gradient magnitude exceeds the threshold are painted with a user-selectable color. Uses `__TEXTURE__` params for multi-pixel access.

- **UI Params:** Edge Threshold, Peak Color (R/G/B), Desaturate Base toggle, Desaturation Strength

#### `skin_tone_indicator.dctl`
Highlights pixels within the skin tone hue range (~28 degrees HSV, corresponding to the vectorscope I-line at ~123 degrees). Two overlay modes: desaturate everything except skin, or tint skin regions with a warm overlay.

- **UI Params:** Skin Hue Center, Hue Tolerance, Min/Max Saturation, Min Brightness, Overlay Mode, Desaturation

### Diagnostic

#### `gamut_check.dctl`
Highlights out-of-range pixels when working in wide gamut spaces. Color-codes pixels with channel values outside the valid range.

| Color | Condition |
|-------|-----------|
| Cyan | Any channel < lower limit (negative values) |
| Red | Any channel > upper limit (super-whites) |
| Magenta | Both negative and super-white channels |

- **UI Params:** Upper Limit, Lower Limit, Overlay Opacity, Show Original Under

#### `chroma_noise_viz.dctl`
Highlights shadow chroma noise: pixels with high chroma magnitude in low-luma regions. Three view modes: overlay on original, isolated noise map, or full chroma heatmap.

- **UI Params:** Luma Ceiling, Chroma Threshold, Overlay Opacity, View Mode

## Project Structure

```
dctl-toolkit/
├── README.md
├── install.sh
├── transforms/
│   ├── clog3_to_linear.dctl
│   └── clog3_to_rec709.dctl
├── visualization/
│   ├── false_color_clog3.dctl
│   ├── zebras.dctl
│   ├── focus_peaking.dctl
│   └── skin_tone_indicator.dctl
├── diagnostic/
│   ├── gamut_check.dctl
│   └── chroma_noise_viz.dctl
└── reference/
```

## DCTL Reference

- Files are C-like, compiled at load time by Resolve's GPU compiler
- Standard signature: `__DEVICE__ float3 transform(int p_Width, int p_Height, int p_X, int p_Y, float p_R, float p_G, float p_B)`
- Multi-pixel signature (focus peaking): uses `__TEXTURE__` params for neighborhood access
- Math intrinsics: `_powf`, `_logf`, `_log10f`, `_fabs`, `_fminf`, `_fmaxf`, `_sqrtf`
- UI controls: `DEFINE_UI_PARAMS(name, label, type, default, ...)`
- Compile errors visible in: Workspace -> Console

## Testing

1. Apply each DCTL on a test clip in the Color page
2. Verify behavior against known references (grey card, skin tone chart, clipped highlights)
3. Check Workspace -> Console for any compile errors after loading

## Requirements

- DaVinci Resolve 18+ (Studio recommended for full DCTL support)
- GPU with OpenCL, CUDA, or Metal support

## References

- Blackmagic DCTL documentation: bundled with Resolve at `<install>/Developer/DCTL/`
- Canon Log 3 Transfer Characteristics white paper
- Canon Cinema Gamut primaries specification
