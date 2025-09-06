{ pkgs, ... }:

{
  services.postgresql = {
    enable = true;

    enableJIT = true;

    settings = {
      random_page_cost = 1.2;

      jit_above_cost = 500000;

      autovacuum_vacuum_cost_limit = 2000;
      autovacuum_vacuum_scale_factor = 0.01;
    };

    package = pkgs.postgresql_17;
  };
}
