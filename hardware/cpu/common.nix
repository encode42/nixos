{ isLaptop, ... }:

{
  #services.auto-cpufreq.enable = isLaptop;
}
