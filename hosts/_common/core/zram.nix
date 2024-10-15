{ ... }:

{
  zramSwap = {
    enable = true;
    memoryMax = 2 * 1024 * 1024 * 1024;
    swapDevices = [
      {
        device = "/dev/zram0";
        priority = 100; # Higher priority than disk swap
      }
    ];
  };
}
