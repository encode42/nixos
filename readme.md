Personal-use NixOS configuration files.

- `hardware`: Specialized hardware configuration
- `homes`: User-owned home-manager directories
- `hosts`: Machine configuration
  - `users`: Machine-owned users on the machine
  - `homes`: User-owned home-manager configurations
- `lib`: Helper functions
- `modules`: System modules and relevant configuration
- `packages`: Program package configuration
- `users`: Machine-owned common user configuration

Useful resources:
- [Disko Quickstart](https://github.com/nix-community/disko/blob/master/docs/quickstart.md)
- `sudo nixos-install --no-root-passwd --flake github:encode42/nixos#host`
- don't forget to set password! `sudo nixos-enter -c "passwd user"`