{ pkgs, ... }:
{
  home.packages = with pkgs; [
    blender
    renderdoc
    vulkan-loader
  ];
}
