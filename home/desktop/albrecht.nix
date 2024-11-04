{ inputs, pkgs, ... }:
{
  home.packages = (with pkgs; [
    vulkan-loader
  ]) ++ (with inputs.stable.legacyPackages.${pkgs.system}; [
    blender
    renderdoc
  ]);
}
