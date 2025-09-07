{
  hosts ? [ ],
}:

{
  config,
  lib,
  flakeLib,
  ...
}:

{
  services.searx = {
    enable = true;

    redisCreateLocally = true;

    runInUwsgi = true;
    uwsgiConfig = {
      socket = "/run/searx/searx.sock";
      http = ":8888";
      chmod-socket = "660";
    };

    settings = {
      general = {
        donation_url = false;
        contact_url = false;
        enable_metrics = false;
      };

      ui = {
        center_alignment = true;
        infinite_scroll = true;

        cache_url = "https://archive.today/";

        static_use_hash = true;
        query_in_title = false;
      };

      search = {
        autocomplete = "duckduckgo";
        favicon_resolver = "allesedv";

        formats = [
          "html"
          "json"
        ];
      };

      server = {
        public_instance = true;
        limiter = true;

        image_proxy = true;

        method = "GET";

        bind_address = "127.0.0.1";
      };

      limiterSettings = {
        real_ip = {
          x_for = 1;
        };

        botdetection = {
          ip_limit = {
            filter_link_local = true;
            link_token = false;
          };
        };
      };

      engines = lib.mapAttrsToList (name: value: { inherit name; } // value) {
        # GENERAL
        # translate
        "dictzone".disabled = true;
        "libretranslate".disabled = true;
        "lingva".disabled = true;
        "mozhi".disabled = true;
        "mymemory translated".disabled = true;

        # web
        "bing".disabled = true;
        "brave".disabled = false;
        "duckduckgo".disabled = false;
        "google".disabled = true;
        "mojeek".disabled = true;
        "presearch".disabled = true;
        "presearch videos".disabled = true;
        "qwant".disabled = true;
        "startpage".disabled = true;
        "wiby".disabled = true;
        "yahoo".disabled = true;
        "seznam (CZ)".disabled = true;
        "goo (JA)".disabled = true;
        "naver (KO)".disabled = true;

        # wikimedia
        "wikibooks".disabled = true;
        "wikiquote".disabled = true;
        "wikisource".disabled = true;
        "wikispecies".disabled = true;
        "wikiversity".disabled = true;
        "wikivoyage".disabled = true;

        # custom
        "modrinth" = {
          disabled = true;
          categories = [ "general" ];
          shortcut = "mr";

          engine = "json_engine";

          search_url = "https://api.modrinth.com/v2/search?query={query}&offset={pageno}&limit=1&index=relevance&facets=%5B%5B%22downloads%20%3E=%20500%22%5D%5D";
          paging = true;
          page_size = 1;
          first_page_num = 0;

          results_query = "hits";
          title_query = "title";
          content_query = "description";
          thumbnail_query = "featured_gallery";
          url_query = "project_id";
          url_prefix = "https://modrinth.com/project/";

          weight = 1;
        };

        # without further subgrouping
        "ask".disabled = true;
        "cloudflareai".disabled = true;
        "crowdview".disabled = true;
        "curlie".disabled = true;
        "currency".disabled = false;
        "ddg definitions".disabled = true;
        "encyclosearch".disabled = true;
        "mwmbl".disabled = true;
        "right dao".disabled = true;
        "searchmysite".disabled = true;
        "stract".disabled = true;
        "tineye".disabled = false;
        "wikidata".disabled = true;
        "wikipedia" = {
          disabled = false;

          weight = 2;
        };
        "wolframalpha".disabled = true;
        "yacy".disabled = true;
        "yep".disabled = true;
        "bpb (DE)".disabled = true;
        "tagesschau (DE)".disabled = true;
        "wikimini (FR)".disabled = true;

        # IMAGES
        # web
        "bing images".disabled = true;
        "brave.images".disabled = true;
        "duckduckgo images".disabled = true;
        "google images".disabled = false;
        "mojeek images".disabled = true;
        "presearch images".disabled = true;
        "qwant images".disabled = true;

        # without further subgrouping
        "1x".disabled = true;
        "adobe stock".disabled = true;
        "artic".disabled = true;
        "deviantart" = {
          disabled = false;

          weight = 0.2;
        };
        "findthatmeme".disabled = true;
        "flickr".disabled = true;
        "frinkiac".disabled = true;
        "imgur" = {
          disabled = false;

          weight = 0.2;
        };
        "library of congress".disabled = true;
        "material icons".disabled = true;
        "openverse" = {
          disabled = false;

          weight = 0.5;
        };
        "pinterest".disabled = true;
        "svgrepo".disabled = true;
        "unsplash" = {
          disabled = false;

          weight = 0.5;
        };
        "wallhaven".disabled = true;
        "wikicommons.images" = {
          disabled = false;

          weight = 2;
        };
        "yacy images".disabled = true;
        "yep images".disabled = true;
        "seekr images (EN)".disabled = true;

        # VIDEOS
        # web
        "bing videos".disabled = false;
        "brave.videos".disabled = true;
        "duckduckgo videos".disabled = true;
        "google videos".disabled = true;
        "qwant videos".disabled = true;

        # without further subgrouping
        "adobe stock video".disabled = true;
        "bilibili" = {
          disabled = false;

          weight = 0.2;
        };
        "dailymotion".disabled = true;
        "google play movies".disabled = true;
        "invidious".disabled = true;
        "livespace".disabled = true;
        "media.ccc.de".disabled = true;
        "odysee".disabled = false;
        "peertube".disabled = true;
        "piped".disabled = true;
        "rumble".disabled = true;
        "sepiasearch".disabled = false;
        "vimeo" = {
          disabled = false;

          weight = 0.5;
        };
        "wikicommons.videos" = {
          disabled = false;

          weight = 2;
        };
        "youtube".disabled = false;
        "mediathekviewweb (DE)".disabled = true;
        "seekr videos (EN)".disabled = true;
        "ina (FR)".disabled = true;

        # NEWS
        # web
        "duckduckgo news".disabled = true;
        "mojeek news".disabled = false;

        # wikimedia
        "wikinews" = {
          disabled = false;

          weight = 2;
        };

        # without further subgrouping
        "bing news".disabled = true;
        "brave.news".disabled = true;
        "google news".disabled = true;
        "qwant news".disabled = true;
        "yahoo news".disabled = true;
        "yep news".disabled = true;
        "seekr news (EN)".disabled = true;

        # MAP
        "apple maps".disabled = true;
        "openstreetmap".disabled = false;
        "photon".disabled = true;

        # MUSIC
        # lyrics
        "genius".disabled = false;

        # radio
        "radio browser".disabled = false;

        # without further subgrouping
        "adobe stock audio".disabled = true;
        "bandcamp" = {
          disabled = false;

          weight = 2;
        };
        "deezer".disabled = true;
        "mixcloud".disabled = true;
        "piped.music".disabled = true;
        "soundcloud" = {
          disabled = false;

          weight = 0.5;
        };
        "wikicommons.audio" = {
          disabled = false;

          weight = 0.2;
        };

        # IT
        # packages
        "alpine linux packages".disabled = true;
        "crates.io" = {
          disabled = false;

          weight = 0.6;
        };
        "docker hub".disabled = true;
        "hex".disabled = true;
        "hoogle".disabled = true;
        "lib.rs".disabled = true;
        "metacpan".disabled = true;
        "npm" = {
          disabled = false;

          weight = 0.6;
        };
        "packagist".disabled = true;
        "pkg.go.dev" = {
          disabled = false;

          weight = 0.6;
        };
        "pub.dev" = {
          disabled = false;

          weight = 0.5;
        };
        "pypi" = {
          disabled = false;

          weight = 0.5;
        };
        "rubygems".disabled = true;
        "voidlinux".disabled = true;

        # q&a
        "askubuntu".disabled = true;
        "caddy.community".disabled = false;
        "discuss.python".disabled = true;
        "pi-hole.community".disabled = true;
        "stackoverflow".disabled = false;
        "superuser".disabled = false;

        # repos
        "bitbucket" = {
          disabled = false;

          weight = 0.7;
        };
        "codeberg" = {
          disabled = false;

          weight = 0.8;
        };
        "gitea.com" = {
          disabled = false;

          weight = 0.8;
        };
        "github" = {
          disabled = false;

          weight = 0.8;
        };
        "gitlab" = {
          disabled = false;

          weight = 0.7;
        };
        "sourcehut" = {
          disabled = false;

          weight = 0.7;
        };

        # software wikis
        "arch linux wiki".disabled = false;
        "free software directory".disabled = true;
        "gentoo".disabled = true;

        # without further subgrouping
        "anaconda".disabled = true;
        "cpprefrence".disabled = true;
        "habrahabr".disabled = true;
        "hackernews".disabled = false;
        "lobste.rs".disabled = false;
        "mankier" = {
          disabled = false;

          weight = 2;
        };
        "mdn" = {
          disabled = false;

          weight = 2;
        };
        "searchcode".disabled = true;

        # SCIENCE
        # scientific publications
        "arxiv".disabled = true;
        "crossref".disabled = true;
        "google scholar".disabled = false;
        "pubmed".disabled = false;
        "semanticscholar".disabled = true;

        # without further subgrouping
        "openairedatasets".disabled = true;
        "openairepublications".disabled = true;
        "pdbe".disabled = true;

        # FILES
        # apps
        "apk mirror".disabled = true;
        "apple app store".disabled = false;
        "fdroid".disabled = false;
        "google play apps" = {
          disabled = false;

          weight = 0.8;
        };

        # without further subgrouping
        "1337x".disabled = true;
        "annas archive".disabled = true;
        "bt4g".disabled = true;
        "btdigg".disabled = true;
        "kickass".disabled = true;
        "library genesis".disabled = true;
        "nyaa".disabled = true;
        "openrepos".disabled = true;
        "piratebay".disabled = true;
        "solidtorrents".disabled = true;
        "tokyotoshokan".disabled = true;
        "wikicommons.files".disabled = false;
        "z-library".disabled = true;

        # SOCIAL MEDIA
        "9gag".disabled = true;
        "lemmy comments".disabled = false;
        "lemmy communities".disabled = true;
        "lemmy posts".disabled = false;
        "lemmy users".disabled = true;
        "mastodon hashtags".disabled = false;
        "mastodon users".disabled = true;
        "reddit" = {
          disabled = false;

          weight = 1.2;
        };
        "tootfinder".disabled = false;

        # OTHER
        # dictionaries
        "etymonline".disabled = true;
        "wiktionary".disabled = true;
        "wordnik".disabled = true;
        "duden (DE)".disabled = true;
        "woxikon.de synonyme (DE)".disabled = true;
        "jisho (JA)".disabled = true;
        "sjp.pwn (PL)".disabled = true;

        # movies
        "imdb".disabled = true;
        "rottentomatoes".disabled = true;
        "tmdb".disabled = true;
        "moviepilot (DE)".disabled = true;

        # shopping
        "geizhals (DE)".disabled = true;

        # weather
        "duckduckgo weather".disabled = true;
        "openmeteo".disabled = true;
        "wttr.in".diasbled = true;

        # without further subgrouping
        "emojipedia".disabled = true;
        "erowid".disabled = true;
        "fyyd".disabled = true;
        "goodreads".disabled = true;
        "openlibrary".disabled = true;
        "podcastindex".disabled = true;
        "yummly".disabled = true;
        "chefkoch (DE)".disabled = true;
        "destatis (DE)".disabled = true;
      };

      enabled_plugins = [
        "Unit converter plugin"
        "Self Information"
        "Hash plugin"
        "Open Access DOI rewrite"
        "Tracker URL remover"
      ];
    };
  };

  services.caddy.virtualHosts = flakeLib.mkProxies hosts ''
    reverse_proxy unix/${config.services.searx.uwsgiConfig.socket} {
      transport uwsgi

      header_up X-Forwarded-For {http.request.header.CF-Connecting-IP}
      header_up X-Real-IP {http.request.header.CF-Connecting-IP}
    }
  '';

  users.users.caddy.extraGroups = [ config.users.users.searx.group ];
}
