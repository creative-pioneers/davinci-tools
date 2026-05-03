# DaVinci Tools

GPU-accelerated DCTL effects, LUTs, scripts, and utilities for DaVinci Resolve — general-purpose color grading tools supporting multiple camera systems and log formats.

## DCTL Toolkit

The [`dctl-toolkit/`](dctl-toolkit/) directory contains a collection of DCTL (DaVinci Color Transform Language) files that run as per-pixel GPU effects in Resolve's Color page.

### Tools

| Category | Tool | Description |
|----------|------|-------------|
| **Transforms** | `clog3_to_linear` | Canon C-Log 3 to scene-linear |
| | `clog3_to_rec709` | C-Log 3 / Cinema Gamut to Rec.709 display |
| | `slog3_to_linear` | Sony S-Log3 to scene-linear |
| | `slog3_to_rec709` | S-Log3 / S-Gamut3.Cine to Rec.709 display |
| | `logc3_to_linear` | ARRI LogC3 to scene-linear |
| | `logc3_to_rec709` | LogC3 / ARRI Wide Gamut 3 to Rec.709 display |
| **Visualization** | `false_color_clog3` | Exposure zone map tuned for C-Log 3 IRE values |
| | `zebras` | Diagonal stripe overlay on clipped/crushed pixels |
| | `focus_peaking` | Edge detection overlay for focus verification |
| | `skin_tone_indicator` | Skin tone hue range highlighting |
| | `false_color` | Format-agnostic false color with adjustable zone thresholds |
| | `split_tone` | Shadow/highlight hue shift with smooth crossover zone |
| **Diagnostic** | `gamut_check` | Out-of-range pixel detection for wide gamut work |
| | `chroma_noise_viz` | Shadow chroma noise visualization |
| | `channel_isolation` | Per-channel greyscale view or R/G/B triptych |

### Quick Start

```bash
cd dctl-toolkit
./install.sh
```

This symlinks all `.dctl` files into Resolve's LUT directory. See [`dctl-toolkit/README.md`](dctl-toolkit/README.md) for detailed documentation on each tool, UI parameters, and manual installation.

## Requirements

- DaVinci Resolve 18+ (Studio recommended)
- GPU with OpenCL, CUDA, or Metal support

## License

See [LICENSE](LICENSE).
