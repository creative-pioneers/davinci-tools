# DaVinci Tools

GPU-accelerated DCTL effects, LUTs, scripts, and utilities for DaVinci Resolve — general-purpose tooling not tied to any specific camera system or log format.

## Tech Stack

- **Language**: DCTL (DaVinci Color Transform Language — C-like GPU shader language compiled by Resolve)
- **Scripting**: Bash (install/uninstall tooling)
- **Target platform**: DaVinci Resolve 18+ (Studio recommended)
- **GPU backends**: OpenCL, CUDA, Metal

## Architecture

Tools are organized by function under `dctl-toolkit/`:

```
dctl-toolkit/
├── transforms/      # Log-to-linear and log-to-display conversions
├── visualization/   # On-set and in-grade monitoring overlays
├── diagnostic/      # Gamut, noise, and exposure diagnostics
└── install.sh       # Symlinks all .dctl files into Resolve's LUT directory
```

Each DCTL file is a self-contained GPU effect applied as a node in Resolve's Color page. Tools in different categories may share utility functions — prefer inline helpers over separate include files unless the shared logic spans 3+ tools.

## Development

### Prerequisites

- DaVinci Resolve 18+ installed
- GPU with OpenCL, CUDA, or Metal support
- bash (for install script)

### Getting Started

```sh
cd dctl-toolkit
./install.sh        # symlinks all .dctl files into Resolve's LUT directory
./install.sh --uninstall
```

After installing, right-click in the DCTL picker in Resolve and select **Update Lists**.

### Commands

| Command | Purpose |
|---------|---------|
| `./install.sh` | Symlink all DCTL files into Resolve's LUT directory |
| `./install.sh --uninstall` | Remove symlinks |

### DCTL Development Notes

- Standard function signature: `__DEVICE__ float3 transform(int p_Width, int p_Height, int p_X, int p_Y, float p_R, float p_G, float p_B)`
- Multi-pixel access (e.g., for convolution kernels): use `__TEXTURE__` params
- Math intrinsics: `_powf`, `_logf`, `_log10f`, `_fabs`, `_fminf`, `_fmaxf`, `_sqrtf`
- UI parameters: `DEFINE_UI_PARAMS(name, label, DCTLUI_*, default, ...)`
- Compile errors are visible in Resolve under **Workspace → Console**

### Testing

1. Apply each DCTL on a test clip in the Color page
2. Verify behavior against known references (grey card, skin tone chart, clipped highlights)
3. Check **Workspace → Console** for compile errors after loading

## Conventions

- **Naming**: `<function>_<subject>.dctl` — e.g., `clog3_to_rec709.dctl`, `false_color_clog3.dctl`
- **New tools**: place in the appropriate category directory (`transforms/`, `visualization/`, `diagnostic/`)
- **Log format support**: when adding support for a new camera log, create both a linearization transform and update or add relevant visualization tools tuned for that log's encoding range
- **UI params**: always provide sensible defaults; document parameter ranges in the file header comment
- **No build step**: DCTL files are compiled at load time by Resolve — keep each file self-contained
- **Git**: Conventional Commits (`feat:`, `fix:`, `docs:`, `refactor:`), branch naming `feat/<name>` / `fix/<name>`

## MRLM Plugin Usage

This project uses the [mrlm devstack plugin](https://github.com/mrlm-net/devstack) for AI-assisted development. Available commands:

| Command | What it does |
|---------|-------------|
| `/spec` | Gather requirements, write user stories and acceptance criteria |
| `/design` | Design system architecture, define interfaces and technical patterns |
| `/build` | Implement code and unit tests (engineer only, no review) |
| `/review` | Systematic code review for correctness, style, and performance |
| `/test` | Run E2E, performance, UX, and accessibility testing |
| `/secure` | Vulnerability scan, SBOM generation, OWASP compliance check |
| `/deploy` | Infrastructure provisioning and deployment automation |
| `/make` | Full SDLC pipeline — from requirements through security scan |
| `/ask` | Ask any question using full agent toolkit (read-only) |
| `/write` | Generate articles, documentation, or marketing content |
| `/release` | Publish versioned release with changelog, git tag, and GitHub Release |
| `/scope` | Plan from issue/work item or topic — analysis, design, planning, and backlog creation |
| `/init` | Initialize project structure and CLAUDE.md |

### Recommended Workflow

For new tools or log format support: `/make [description]`

For focused work, chain individual commands:
1. `/spec` — define what to build
2. `/design` — plan how to build it
3. `/build` — implement it
4. `/review` — review the code
5. `/test` — verify it works
