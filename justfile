hostname := `hostname -s`

_default:
    just --list

_pull:
    git pull

pre-commit: fmt

fmt:
    nix run nixpkgs#alejandra -- .

update: _pull
    #!/usr/bin/env nu

    # bump nixpkgs-unstable
    let offset = (date now) - 3day
    let query = {until: $offset, sha: "master", per_page: 1, page: 1}
    let hash = http get $"https://api.github.com/repos/nixos/nixpkgs/commits?($query | url build-query)" | first | get sha
    sed -i $'s!nixpkgs-unstable.url =.*!nixpkgs-unstable.url = "github:nixos/nixpkgs/($hash)";!' flake.nix
    git add flake.nix

    # update the flake
    nix flake update
    git add flake.lock

    # commit our update
    git commit -m "flake: update inputs"

rebuild-hm: _pull
    chezmoi update -a
    home-manager switch --flake '.#{{hostname}}'

rebuild-nixos: _pull
    sudo nixos-rebuild switch --flake '.#{{hostname}}'
