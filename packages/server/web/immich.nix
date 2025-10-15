{
  hosts ? [ ],
}:

{
  config,
  flakeLib,
  ...
}:

let
  videoDevice = "/dev/dri/renderD128";
in
{
  imports = [
    ../databases/postgresql.nix
    ../databases/redis.nix
  ];

  services.immich = {
    enable = true;

    host = "127.0.0.1";

    accelerationDevices = [ videoDevice ];

    database = {
      enableVectors = false;
      enableVectorChord = true;
    };

    settings = {
      trash.days = 31;

      image = {
        thumbnail = {
          size = 240;
          quality = 50;
        };

        preview = {
          format = "webp";
          size = 1080;
          quality = 75;
        };
      };

      ffmpeg = {
        acceptedContainers = [ "webm" ];
        acceptedVideoCodecs = [
          "hevc"
          "vp9"
          "av1"
        ];
        acceptedAudioCodecs = [ "libopus" ];

        targetVideoCodec = "hevc";
        targetAudioCodec = "libopus";

        crf = 31;
        #maxBitrate = 2600;
        twoPass = true;

        # assumes AMD GPU, to modularize
        accel = "vaapi";
        preferredHwDevice = videoDevice;
        accelDecode = true;
      };

      machineLearning = {
        # Assumes the machine is powerful, while balancing speed
        # "ViT-B-32__laion2b-s34b-b79k" uses a third of the memory and is ~twice as fast, but is ~10% less accurate
        clip.modelName = "ViT-B-16-SigLIP2__webli";

        facialRecognition = {
          # Largest model, generally very accurate
          modelName = "antelopev2";

          minScore = 0.5;
          minFaces = 5;
        };
      };

      # Assumes we're keeping copies elsewhere (zfs snapshots)
      backup.database.enabled = false;
    };
  };

  users.users.immich.extraGroups = [
    "video"
    "render"
  ];

  services.caddy.virtualHosts = flakeLib.mkProxies hosts ''
    reverse_proxy :${toString config.services.immich.port}
  '';
}
