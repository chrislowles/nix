{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/release-24.11";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
        jovian = {
            url = "github:Jovian-Experiments/Jovian-NixOS";
            inputs.nixos.follows = "nixos-unstable";
        };
        #...
    }
};