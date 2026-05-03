# DaVinci Resolve DCTL Toolkit

Multi-format color grading tools for DaVinci Resolve 18+, implemented as DCTL (DaVinci Color Transform Language) per-pixel GPU effects. Supports Canon C-Log 3, Sony S-Log3, ARRI LogC3, and more. All tools operate per-pixel on the GPU and are applied as node effects in the Color page.

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

### Format-Agnostic Tools

The following tools work on any input signal regardless of camera system or log format. Apply them after a log-to-display transform or directly on Rec.709 footage:

- `zebras` — clipping/crushing indicator stripes
- `focus_peaking` — edge detection overlay for focus verification
- `skin_tone_indicator` — skin tone hue range highlighting
- `gamut_check` — out-of-range pixel detection
- `chroma_noise_viz` — shadow chroma noise visualization
- `false_color` — exposure zone map with adjustable thresholds
- `channel_isolation` — per-channel greyscale or R/G/B triptych
- `split_tone` — shadow/highlight hue shift with smooth crossover
- `color_temp_estimate` — warm/cool R/B bias visualizer for mixed lighting detection

### Transforms

#### `clog3_to_linear.dctl`
Converts Canon C-Log 3 signal to scene-linear light. Implements the full piecewise inverse of the Canon C-Log 3 transfer function including the linear segment near zero. Use as a utility node before other processing that expects linear input.

- **Input:** Canon C-Log 3 encoded
- **Output:** Scene-linear (same gamut as input)

#### `clog3_to_rec709.dctl`
Full pipeline from Canon C-Log 3 / Cinema Gamut to Rec.709 display. Applies C-Log 3 linearization, Cinema Gamut to Rec.709 3x3 matrix, and Rec.709 OETF. Use as a quick-look transform or starting point for grading.

- **Input:** Canon C-Log 3, Cinema Gamut
- **Output:** Rec.709 gamma-encoded

#### `slog3_to_linear.dctl`
Converts Sony S-Log3 signal to scene-linear light. Implements the full piecewise inverse of the Sony S-Log3 transfer function (EI 800). Gamut-agnostic — works with S-Gamut3, S-Gamut3.Cine, or any Sony S-Gamut variant.

- **Input:** Sony S-Log3 encoded
- **Output:** Scene-linear (same gamut as input)
- **Reference:** Sony S-Log3 Transfer Characteristics white paper (2016)

#### `slog3_to_rec709.dctl`
Full pipeline from Sony S-Log3 / S-Gamut3.Cine to Rec.709 display. Applies S-Log3 linearization, S-Gamut3.Cine to Rec.709 3x3 matrix, and Rec.709 OETF.

- **Input:** Sony S-Log3, S-Gamut3.Cine
- **Output:** Rec.709 gamma-encoded

#### `logc3_to_linear.dctl`
Converts ARRI LogC3 signal to scene-linear light. Implements the piecewise inverse of the ARRI LogC3 transfer function at EI 800.

- **Input:** ARRI LogC3 encoded (ARRI Wide Gamut 3)
- **Output:** Scene-linear (same gamut as input)
- **Reference:** ARRI LogC Curve Usage in VFX (2017), EI 800 table

#### `logc3_to_rec709.dctl`
Full pipeline from ARRI LogC3 / ARRI Wide Gamut 3 to Rec.709 display. Applies LogC3 linearization (EI 800), AWG3 to Rec.709 3x3 matrix, and Rec.709 OETF.

- **Input:** ARRI LogC3, ARRI Wide Gamut 3
- **Output:** Rec.709 gamma-encoded

#### `bfilm5_to_linear.dctl`
Converts Blackmagic Film Gen5 signal to scene-linear light. Implements the inverse of Blackmagic's log2-based Gen5 transfer function. Compatible with BMPCC 6K G2, URSA Mini Pro 12K, and any camera recording in BM Film Gen5.

- **Input:** Blackmagic Film Gen5 encoded
- **Output:** Scene-linear (same gamut as input)

#### `bfilm5_to_rec709.dctl`
Full pipeline from Blackmagic Film Gen5 to Rec.709 display. Applies Gen5 linearization and the Blackmagic Film Wide Gamut to Rec.709 3x3 matrix, followed by Rec.709 OETF.

- **Input:** Blackmagic Film Gen5
- **Output:** Rec.709 gamma-encoded

#### `slog2_to_linear.dctl`
Converts Sony S-Log2 signal to scene-linear light. Implements the full piecewise inverse of the Sony S-Log2 transfer function. Compatible with A7S II, FS7, RX series, and other cameras recording in S-Log2.

- **Input:** Sony S-Log2 encoded
- **Output:** Scene-linear (same gamut as input)

#### `slog2_to_rec709.dctl`
Full pipeline from Sony S-Log2 to Rec.709 display. Includes a gamut selector combo box to choose between S-Gamut3.Cine and the original S-Gamut primaries, followed by Rec.709 OETF.

- **Input:** Sony S-Log2, S-Gamut3.Cine or S-Gamut
- **Output:** Rec.709 gamma-encoded
- **UI Params:** Gamut (S-Gamut3.Cine / S-Gamut)

#### `log3g10_to_linear.dctl`
Converts RED Log3G10 signal to scene-linear light. Implements the inverse of the REDWideGamutRGB / Log3G10 transfer function. Allows negative linear output — RED cameras encode below-black values and this transform preserves that range.

- **Input:** RED Log3G10 encoded (REDWideGamutRGB)
- **Output:** Scene-linear (negative values preserved for below-black)
- **Cameras:** KOMODO, V-RAPTOR, DSMC2 series

#### `log3g10_to_rec709.dctl`
Full pipeline from RED Log3G10 / REDWideGamutRGB to Rec.709 display. Applies Log3G10 linearization, REDWideGamutRGB to Rec.709 3x3 matrix, and Rec.709 OETF.

- **Input:** RED Log3G10, REDWideGamutRGB
- **Output:** Rec.709 gamma-encoded

#### `vlogl_to_linear.dctl`
Converts Panasonic V-Log L signal to scene-linear light. Implements the inverse of the V-Log L transfer function. Compatible with GH5, S1H, G9, BGH1, S5 II, and other Panasonic cameras recording in V-Log L.

- **Input:** Panasonic V-Log L encoded
- **Output:** Scene-linear (same gamut as input)

#### `vlogl_to_rec709.dctl`
Full pipeline from Panasonic V-Log L to Rec.709 display. Applies V-Log L linearization, V-Gamut to Rec.709 3x3 matrix, and Rec.709 OETF.

- **Input:** Panasonic V-Log L, V-Gamut
- **Output:** Rec.709 gamma-encoded

#### `logc4_to_linear.dctl`
Converts ARRI LogC4 signal to scene-linear light. Implements the inverse of ARRI's log2-based LogC4 transfer function. ALEXA 35 only — for ALEXA Mini / Mini LF / Amira use `logc3_to_linear.dctl`. No EI dependence.

- **Input:** ARRI LogC4 encoded (ARRI Wide Gamut 4)
- **Output:** Scene-linear (same gamut as input)
- **Reference:** ARRI Science — "ALEXA 35 LogC4 Transfer Characteristic"

#### `logc4_to_rec709.dctl`
Full pipeline from ARRI LogC4 / ARRI Wide Gamut 4 to Rec.709 display. Applies LogC4 linearization, AWG4 to Rec.709 3x3 matrix, and Rec.709 OETF.

- **Input:** ARRI LogC4, ARRI Wide Gamut 4
- **Output:** Rec.709 gamma-encoded
- **Cameras:** ALEXA 35

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

#### `false_color.dctl`
Format-agnostic false color exposure zone map with fully adjustable zone thresholds. Unlike the camera-specific variants, all nine zone boundaries are exposed as UI sliders so the tool adapts to any log encoding or display-referred signal.

- **UI Params:** Nine zone threshold sliders (Zone 1–9 Threshold)
- **Input:** Any signal (log, linear, Rec.709)

#### `false_color_slog3.dctl`
False color exposure zone map with thresholds derived from Sony S-Log3 IRE encoding values.

| Color | Zone | S-Log3 IRE |
|-------|------|------------|
| Purple | Crushed blacks | < 0.030 |
| Blue | Deep shadows | 0.030 - 0.076 |
| Teal | Shadow detail | 0.076 - 0.348 |
| Green | Middle grey (18%) | 0.348 - 0.410 |
| Grey | Upper midtones | 0.410 - 0.480 |
| Pink | Skin tones | 0.480 - 0.520 |
| Yellow | Highlights | 0.520 - 0.598 |
| Orange | Hot highlights | 0.598 - 0.729 |
| Red | Clipped | > 0.729 |

- **Input:** Sony S-Log3 encoded

#### `false_color_logc3.dctl`
False color exposure zone map with thresholds derived from ARRI LogC3 IRE encoding values (EI 800).

| Color | Zone | LogC3 IRE |
|-------|------|-----------|
| Purple | Crushed blacks | < 0.123 |
| Blue | Deep shadows | 0.123 - 0.218 |
| Teal | Shadow detail | 0.218 - 0.345 |
| Green | Middle grey (18%) | 0.345 - 0.391 |
| Grey | Upper midtones | 0.391 - 0.453 |
| Pink | Skin tones | 0.453 - 0.491 |
| Yellow | Highlights | 0.491 - 0.553 |
| Orange | Hot highlights | 0.553 - 0.683 |
| Red | Clipped | > 0.683 |

- **Input:** ARRI LogC3 encoded

#### `false_color_bfilm5.dctl`
False color exposure zone map with thresholds tuned for Blackmagic Film Gen5 IRE encoding values. Middle grey is centered at ~0.298 IRE — notably lower than log10-based formats due to the log2 encoding used by Blackmagic Gen5.

| Color | Zone | BM Film Gen5 IRE |
|-------|------|-----------------|
| Purple | Crushed blacks | < 0.04 |
| Blue | Deep shadows | 0.04 - 0.18 |
| Teal | Shadow detail | 0.18 - 0.27 |
| Green | Middle grey (18%) | 0.27 - 0.33 |
| Grey | Upper midtones | 0.33 - 0.42 |
| Pink | Skin tones | 0.42 - 0.52 |
| Yellow | Highlights | 0.52 - 0.70 |
| Orange | Hot highlights | 0.70 - 0.90 |
| Red | Clipped | > 0.90 |

- **Input:** Blackmagic Film Gen5 encoded

#### `false_color_slog2.dctl`
False color exposure zone map with thresholds tuned for Sony S-Log2 IRE encoding values. Middle grey sits at ~0.360 IRE; the wide blue shadow zone reflects S-Log2's compressed shadow encoding.

| Color | Zone | S-Log2 IRE |
|-------|------|------------|
| Purple | Crushed blacks | < 0.090 |
| Blue | Deep shadows | 0.090 - 0.230 |
| Teal | Shadow detail | 0.230 - 0.330 |
| Green | Middle grey (18%) | 0.330 - 0.390 |
| Grey | Upper midtones | 0.390 - 0.455 |
| Pink | Skin tones | 0.455 - 0.510 |
| Yellow | Highlights | 0.510 - 0.636 |
| Orange | Hot highlights | 0.636 - 0.800 |
| Red | Clipped | > 0.800 |

- **Input:** Sony S-Log2 encoded

#### `false_color_logc4.dctl`
False color exposure zone map with thresholds derived from ARRI LogC4 IRE encoding values (ALEXA 35).

| Color | Zone | LogC4 IRE |
|-------|------|-----------|
| Purple | Crushed blacks | < 0.037 |
| Blue | Deep shadows | 0.037 - 0.132 |
| Teal | Shadow detail | 0.132 - 0.225 |
| Green | Middle grey (18%) | 0.225 - 0.285 |
| Grey | Upper midtones | 0.285 - 0.421 |
| Pink | Skin tones | 0.421 - 0.526 |
| Yellow | Highlights | 0.526 - 0.634 |
| Orange | Hot highlights | 0.634 - 0.779 |
| Red | Clipped | > 0.779 |

- **Input:** ARRI LogC4 encoded (ALEXA 35 only)

#### `false_color_vlogl.dctl`
False color exposure zone map with thresholds tuned for Panasonic V-Log L IRE encoding values.

| Color | Zone | V-Log L IRE |
|-------|------|-------------|
| Purple | Crushed blacks | < 0.153 |
| Blue | Deep shadows | 0.153 - 0.218 |
| Teal | Shadow detail | 0.218 - 0.355 |
| Green | Middle grey (18%) | 0.355 - 0.435 |
| Grey | Upper midtones | 0.435 - 0.499 |
| Pink | Skin tones | 0.499 - 0.539 |
| Yellow | Highlights | 0.539 - 0.599 |
| Orange | Hot highlights | 0.599 - 0.730 |
| Red | Clipped | > 0.730 |

- **Input:** Panasonic V-Log L encoded

#### `exposure_grid.dctl`
Stop-relative false color overlay. The user sets a middle grey anchor value for any log format; the tool computes zone boundaries at each full stop above and below that anchor and applies the standard color scheme. Format-agnostic alternative to the camera-specific false color tools — works on any log encoding by dialing in the correct middle grey IRE.

- **UI Params:** Middle Grey Anchor (0.0 – 1.0)
- **Input:** Any log-encoded signal

#### `color_temp_estimate.dctl`
Visualizes per-pixel warm/cool colour temperature bias across the frame. Computes R/B imbalance normalized by luma and renders it as either a tint overlay (warm amber / cool blue blended onto the original image) or a 5-zone bias map (very warm / warm / neutral / cool / very cool). Useful for detecting mixed lighting, shot-to-shot consistency checking, and WB verification before grading.

- **UI Params:** Target R-B Balance, Sensitivity, Min Luma, Show Mode (Tint Overlay / Bias Map)
- **Input:** Any signal (works best on Rec.709 or display-referred signals placed after a log transform)

#### `split_tone.dctl`
Applies independent hue and saturation shifts to shadows and highlights with a smooth crossover region. Place on a node after any log-to-display transform for predictable results.

- **UI Params:** Shadow Hue (0-360), Highlight Hue (0-360), Shadow Saturation, Highlight Saturation, Crossover Point, Crossover Width

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

#### `channel_isolation.dctl`
View individual R, G, or B channels as greyscale, or display all three channels simultaneously as a horizontal R|G|B triptych. Useful for diagnosing per-channel contamination, noise, or alignment issues.

- **UI Params:** Mode (Red / Green / Blue / Triptych R|G|B)
- **Input:** Any color space

#### `banding_viz.dctl`
Detects horizontal and vertical banding artifacts by measuring luma variance across a 5-pixel neighborhood in each direction. Pixels where variance exceeds the detection threshold are highlighted, making subtle codec or sensor banding visible before delivery. Requires DaVinci Resolve Studio (uses multi-pixel `__TEXTURE__` access).

- **UI Params:** Banding Threshold, Highlight Color, View Mode (Horizontal / Vertical / Both)
- **Input:** Any signal
- **Requires:** Resolve Studio

### Grading

#### `luma_key.dctl`
Luma-windowed lift and gain correction with soft keying edges. Isolates a luma range with configurable low/high key points and soft rolloff, then applies independent lift and gain within that range. Format-agnostic — works in any log or display-referred space, and is particularly useful in log spaces where HSL qualifiers key unreliably on flat footage.

- **UI Params:** Low Key, High Key, Soft Low, Soft High, Lift Amount, Gain Amount
- **Input:** Any color space

## Project Structure

```
dctl-toolkit/
├── README.md
├── install.sh
├── transforms/
│   ├── clog3_to_linear.dctl
│   ├── clog3_to_rec709.dctl
│   ├── slog3_to_linear.dctl
│   ├── slog3_to_rec709.dctl
│   ├── logc3_to_linear.dctl
│   ├── logc3_to_rec709.dctl
│   ├── bfilm5_to_linear.dctl
│   ├── bfilm5_to_rec709.dctl
│   ├── slog2_to_linear.dctl
│   ├── slog2_to_rec709.dctl
│   ├── log3g10_to_linear.dctl
│   ├── log3g10_to_rec709.dctl
│   ├── vlogl_to_linear.dctl
│   ├── vlogl_to_rec709.dctl
│   ├── logc4_to_linear.dctl
│   └── logc4_to_rec709.dctl
├── visualization/
│   ├── false_color_clog3.dctl
│   ├── false_color_slog3.dctl
│   ├── false_color_logc3.dctl
│   ├── false_color_bfilm5.dctl
│   ├── false_color_slog2.dctl
│   ├── false_color_logc4.dctl
│   ├── false_color_vlogl.dctl
│   ├── false_color.dctl
│   ├── exposure_grid.dctl
│   ├── color_temp_estimate.dctl
│   ├── zebras.dctl
│   ├── focus_peaking.dctl
│   ├── skin_tone_indicator.dctl
│   └── split_tone.dctl
├── diagnostic/
│   ├── gamut_check.dctl
│   ├── chroma_noise_viz.dctl
│   ├── channel_isolation.dctl
│   └── banding_viz.dctl
├── grading/
│   └── luma_key.dctl
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
