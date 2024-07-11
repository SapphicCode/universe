{pkgs, ...}: {
  users.users.sapphiccode = {
    isNormalUser = true;
    description = "Cassandra";
    extraGroups = ["wheel" "networkmanager" "input" "lp" "scanner" "dialout"];
    shell = pkgs.fish;
  };
  programs.fish.enable = true;
  programs._1password-gui.polkitPolicyOwners = ["sapphiccode"];
}
