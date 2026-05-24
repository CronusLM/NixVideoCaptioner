# NixVideoCaptioner

Nix package for [VideoCaptioner](https://github.com/WEIFENG2333/VideoCaptioner) — AI-powered video captioning tool with ASR, subtitle optimization, translation, and synthesis.

## Usage

```bash
# Add to flake inputs
nix run github:CronusLM/NixVideoCaptioner
```

### In your NixOS config

```nix
inputs.NixVideoCaptioner.url = "github:CronusLM/NixVideoCaptioner";
```

```nix
home.packages = [
  inputs.NixVideoCaptioner.packages.${pkgs.system}.videocaptioner-cuda
];
```

## Package variants

| Attribute | CUDA | Description |
|---|---|---|
| `videocaptioner` | No | CPU-only version |
| `videocaptioner-cuda` | Yes (default) | GPU-accelerated version |

> The CUDA build works on systems without NVIDIA GPUs — faster-whisper automatically falls back to CPU.
