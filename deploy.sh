#!/usr/bin/env bash

nix run home-manager -- switch --flake .#"$(hostname -s)"