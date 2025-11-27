{
  hosts ? [ ],
}:

{
  config,
  flakeLib,
  pkgs-unstable,
  ...
}:

let
  socket = "/run/navidrome/navidrome.sock";
in
{
  services.navidrome = {
    enable = true;

    settings = {
      Address = "unix:${socket}";

      DefaultTheme = "Spotify-ish";
      DefaultUIVolume = 25;

      EnableCoverAnimation = false;
      EnableGravatar = false;
      EnableStarRating = false;
      MaxSidebarPlaylists = 15;

      EnableSharing = true;
      EnableDownloads = true;
      DefaultShareExpiration = "72h";

      Deezer.Enabled = false;
      #LastFM.Enabled = false;
      ListenBrainz.Enabled = false; # TODO: Self-host Maloja
      AlbumPlayCountMode = "normalized";

      EnableInsightsCollector = false;

      Tags.genre.Split = [
        "; "
        ", "
        " / "
        "/"
        "\\"
      ];

      Scanner.ArtistJoiner = ", ";
      Scanner.WatcherWait = "1m";
      Scanner.ScanOnStartup = false;

      LyricsPriority = ".lrc, embedded";
      ArtistArtPriority = "artist.*";
      CoverArtPriority = "cover.*, embedded";
      EnableMediaFileCoverArt = true;
      CoverJpegQuality = 100;

      AutoImportPlaylists = false;

      Subsonic.ArtistParticipations = true;

      ImageCacheSize = "2GB";
      TranscodingCacheSize = "8GB";
    };

    package = pkgs-unstable.navidrome; # TODO: Switch back to stable once BFR is ready
  };

  # Caddy reverse proxy configuration
  users.users.caddy.extraGroups = [ config.users.users.navidrome.group ];

  services.caddy.virtualHosts = flakeLib.mkProxies hosts ''
    reverse_proxy unix/${socket}
  '';
}
