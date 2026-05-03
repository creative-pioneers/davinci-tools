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
| | `slog2_to_linear` | Sony S-Log2 to scene-linear |
| | `slog2_to_rec709` | S-Log2 to Rec.709 (S-Gamut3.Cine or S-Gamut) |
| | `logc3_to_linear` | ARRI LogC3 to scene-linear (EI 800) |
| | `logc3_to_rec709` | LogC3 / ARRI Wide Gamut 3 to Rec.709 display |
| | `logc4_to_linear` | ARRI LogC4 to scene-linear (ALEXA 35) |
| | `logc4_to_rec709` | LogC4 / ARRI Wide Gamut 4 to Rec.709 display |
| | `bfilm5_to_linear` | Blackmagic Film Gen5 to scene-linear |
| | `bfilm5_to_rec709` | BM Film Gen5 / BM Wide Gamut to Rec.709 display |
| | `log3g10_to_linear` | RED Log3G10 to scene-linear |
| | `log3g10_to_rec709` | Log3G10 / REDWideGamutRGB to Rec.709 display |
| | `vlogl_to_linear` | Panasonic V-Log L to scene-linear |
| | `vlogl_to_rec709` | V-Log L / V-Gamut to Rec.709 display |
| **Visualization** | `false_color_clog3` | Exposure zone map tuned for C-Log 3 IRE values |
| | `false_color_slog3` | Exposure zone map tuned for S-Log3 IRE values |
| | `false_color_slog2` | Exposure zone map tuned for S-Log2 IRE values |
| | `false_color_logc3` | Exposure zone map tuned for LogC3 IRE values |
| | `false_color_logc4` | Exposure zone map tuned for LogC4 IRE values (ALEXA 35) |
| | `false_color_bfilm5` | Exposure zone map tuned for BM Film Gen5 IRE values |
| | `false_color_vlogl` | Exposure zone map tuned for V-Log L IRE values |
| | `false_color` | Format-agnostic false color with 9 adjustable zone thresholds |
| | `exposure_grid` | Stop-relative false color anchored to a declared middle grey IRE |
| | `color_temp_estimate` | Per-pixel warm/cool R/B bias map for mixed lighting detection |
| | `zebras` | Diagonal stripe overlay on clipped/crushed pixels |
| | `focus_peaking` | Edge detection overlay for focus verification |
| | `skin_tone_indicator` | Skin tone hue range highlighting |
| | `split_tone` | Shadow/highlight hue shift with smooth crossover zone |
| **Diagnostic** | `gamut_check` | Out-of-range pixel detection for wide gamut work |
| | `chroma_noise_viz` | Shadow chroma noise visualization |
| | `channel_isolation` | Per-channel greyscale view or R/G/B triptych |
| | `signal_range_check` | Legal/full range issues, pedestal, super-white, hard clip detection |
| | `output_qc` | Rec.709 delivery compliance — clip, negative, gamut, near-ceiling |
| | `channel_overload` | Which R/G/B channel is clipping or negative, and by how much |
| | `banding_viz` | Horizontal/vertical banding artifact detector (Resolve Studio) |
| **Grading** | `luma_key` | Luma-windowed lift/gain correction with soft key edges |
| **Visualization** (new) | `format_reference_strip` | Zone legend strip for all 8 formats — waveform calibration |
| | `scope_zone_marker` | Tints zones for scope visibility; green = middle grey curve anchor |

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
