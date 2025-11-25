{ pkgs, ... }:

{
  imports = [
    ./pipewire.nix
  ];

  services.pipewire.extraConfig.pipewire."99-deepfilter-mono-source" = {
    "context.modules" = [
      {
        name = "libpipewire-module-filter-chain";

        args = {
          "node.description" = "DeepFilter Noise Canceling Source";
          "media.name" = "DeepFilter Noise Canceling Source";

          "filter.graph" = {
            nodes = [
              {
                type = "ladspa";
                name = "DeepFilter Mono";
                label = "deep_filter_mono";

                plugin = "${pkgs.deepfilternet}/lib/ladspa/libdeep_filter_ladspa.so";

                control = {
                  "Attenuation Limit (dB)" = 100;
                };
              }
            ];
          };

          "audio.rate" = 48000;
          "audio.position" = "[MONO]";

          "capture.props"."node.passive" = true;
          "playback.props"."media.class" = "Audio/Source";
        };
      }
    ];
  };
}
