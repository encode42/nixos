{
  internal = ''
    tls internal
  '';

  cloudflare = ''
    tls {
      dns cloudflare {env.CF_API_TOKEN}

      resolvers 1.1.1.1
      propagation_delay 60s
    }
  '';
}
