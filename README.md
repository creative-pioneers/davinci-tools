# DaVinci Tools

GPU-accelerated visualization and diagnostic tools for DaVinci Resolve, built for on-set monitoring and in-grade analysis of Canon C-Log 3 footage (Canon R5C).

## DCTL Toolkit

The [`dctl-toolkit/`](dctl-toolkit/) directory contains a collection of DCTL (DaVinci Color Transform Language) files that run as per-pixel GPU effects in Resolve's Color page.

### Tools

| Category | Tool | Description |
|----------|------|-------------|
| **Transforms** | `clog3_to_linear` | Canon C-Log 3 to scene-linear |
| | `clog3_to_rec709` | C-Log 3 / Cinema Gamut to Rec.709 display |
| **Visualization** | `false_color_clog3` | Exposure zone map tuned for C-Log 3 IRE values |
| | `zebras` | Diagonal stripe overlay on clipped/crushed pixels |
| | `focus_peaking` | Edge detection overlay for focus verification |
| | `skin_tone_indicator` | Skin tone hue range highlighting |
| **Diagnostic** | `gamut_check` | Out-of-range pixel detection for wide gamut work |
| | `chroma_noise_viz` | Shadow chroma noise visualization |

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
