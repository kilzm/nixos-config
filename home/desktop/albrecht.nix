{
  inputs,
  pkgs,
  ...
}: {
  home.packages =
    (with pkgs; [
      vulkan-loader
    ])
    ++ (with inputs.stable.legacyPackages.${pkgs.stdenv.hostPlatform.system}; [
      blender
      renderdoc
    ]);
}
