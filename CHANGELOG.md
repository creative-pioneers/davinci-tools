# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [Unreleased]

### Added

- `transforms/clog2_to_linear.dctl` — Canon C-Log 2 linearization; single-segment log formula (no piecewise linear toe), black point at IRE ~0.035, covers ~15.5 stops
- `transforms/clog2_to_rec709.dctl` — full C-Log 2 / Cinema Gamut to Rec.709 display pipeline; uses same Cinema Gamut matrix as C-Log 3
- `visualization/false_color_clog2.dctl` — false color tuned for C-Log 2; middle grey zone centered at ~0.37 IRE; wider highlight headroom than C-Log 3 reflects broader dynamic range
- `transforms/bfilm5_to_linear.dctl` — Blackmagic Film Gen5 linearization for BMPCC 6K G2, URSA Mini Pro 12K, and compatible cameras; log2-based encoding
- `transforms/bfilm5_to_rec709.dctl` — full Blackmagic Film Gen5 to Rec.709 display pipeline
- `visualization/false_color_bfilm5.dctl` — false color tuned for Blackmagic Film Gen5; middle grey zone centered at ~0.298 IRE (lower than log10-based formats due to log2 encoding)
- `transforms/slog2_to_linear.dctl` — Sony S-Log2 linearization for A7S II, FS7, RX series, and compatible cameras
- `transforms/slog2_to_rec709.dctl` — full S-Log2 to Rec.709 display pipeline with gamut selector combo box for S-Gamut3.Cine vs S-Gamut original
- `visualization/false_color_slog2.dctl` — false color tuned for S-Log2; middle grey zone at ~0.360 IRE; wide blue shadow zone reflects S-Log2's compressed shadow encoding
- `transforms/log3g10_to_linear.dctl` — RED Log3G10 / REDWideGamutRGB linearization for KOMODO, V-RAPTOR, and DSMC2 cameras; supports negative linear output for below-black RED encoded values
- `transforms/log3g10_to_rec709.dctl` — full RED Log3G10 / REDWideGamutRGB to Rec.709 display pipeline
- `transforms/vlogl_to_linear.dctl` — Panasonic V-Log L linearization for GH5, S1H, G9, BGH1, and S5 II
- `transforms/vlogl_to_rec709.dctl` — full Panasonic V-Log L to Rec.709 display pipeline
- `visualization/exposure_grid.dctl` — stop-relative false color; user declares a middle grey anchor and the tool colors zones per exposure stop above/below; format-agnostic alternative to fixed false color
- `diagnostic/banding_viz.dctl` — detects horizontal and vertical banding artifacts via luma variance in a 5-pixel neighborhood; requires Resolve Studio (multi-pixel DCTL)
- `grading/luma_key.dctl` — luma-windowed lift/gain correction with soft edges; format-agnostic, useful in log spaces where HSL qualifiers key unreliably
- `visualization/false_color.dctl` — format-agnostic false color with nine fully adjustable zone threshold sliders; works on any log encoding or display-referred signal
- `transforms/slog3_to_linear.dctl` — Sony S-Log3 linearization for FX3, FX6, FX9, VENICE, A7S III footage
- `transforms/slog3_to_rec709.dctl` — full S-Log3 / S-Gamut3.Cine to Rec.709 display pipeline
- `visualization/false_color_slog3.dctl` — exposure zone map with thresholds tuned to S-Log3 IRE encoding values
- `transforms/logc3_to_linear.dctl` — ARRI LogC3 linearization for AMIRA, ALEXA Mini, Mini LF, and compatible cameras at EI 800
- `transforms/logc3_to_rec709.dctl` — full LogC3 / ARRI Wide Gamut 3 to Rec.709 display pipeline
- `visualization/false_color_logc3.dctl` — exposure zone map with thresholds tuned to LogC3 IRE encoding values at EI 800
- `diagnostic/channel_isolation.dctl` — view R, G, or B channels as greyscale, or split the frame into a horizontal R|G|B triptych for per-channel diagnostics
- `visualization/split_tone.dctl` — shadow/highlight hue shift with configurable hue, saturation, crossover point, and crossover width
- `transforms/logc4_to_linear.dctl` — ARRI LogC4 linearization for ALEXA 35; log2-based encoding with no EI dependence
- `transforms/logc4_to_rec709.dctl` — full ARRI LogC4 / ARRI Wide Gamut 4 to Rec.709 display pipeline for ALEXA 35 footage
- `visualization/false_color_logc4.dctl` — false color tuned for ARRI LogC4 IRE values; middle grey zone centered at ~0.276 IRE (ALEXA 35 only)
- `visualization/false_color_vlogl.dctl` — false color tuned for Panasonic V-Log L; middle grey zone centered at ~0.423 IRE
- `visualization/color_temp_estimate.dctl` — per-pixel warm/cool colour temperature bias visualizer; shows spatial R/B imbalance distribution across the frame in tint overlay or 5-zone bias map modes
- `diagnostic/signal_range_check.dctl` — detects legal vs full range issues, sub-black pedestal, approaching-clip super-whites, and hard clips; colour-coded per violation type
- `diagnostic/output_qc.dctl` — Rec.709 delivery compliance checker; flags illegal clips, negatives, potential gamut violations, and near-white-ceiling pixels before export
- `diagnostic/channel_overload.dctl` — shows which specific RGB channel is clipping or going negative and by how much; colour-coded by dominant channel (R/G/B/white for equal)
- `visualization/format_reference_strip.dctl` — overlays a zone-coloured IRE reference strip on the frame edge for all 8 supported log formats; white tick marks at green zone boundaries; useful for waveform calibration and format identification
- `visualization/scope_zone_marker.dctl` — tints tonal zones with scope-visible colours so they appear as labelled clusters on the waveform; green = middle grey lock point for curves, cyan/yellow = creative zones, amber = skin tones (hue-detected)

### Changed

- Removed Canon C-Log 3 / R5C-specific framing from README files; project is now documented as a multi-format toolkit supporting Canon, Sony, and ARRI log formats

### Fixed

- `install.sh` — added APPDATA guard to prevent path errors on Windows/MSYS environments where the variable may be unset
- `visualization/split_tone.dctl` — added NaN guard in `smoothstep_f` to handle degenerate input when `crossover_width` is zero
- `.gitignore` — added secrets and credentials exclusion patterns to prevent accidental credential commits
