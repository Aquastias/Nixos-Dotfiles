{...}: {
  zramSwap = {
    algorithm = "zstd";
    enable = true;
    memoryMax = 2 * 1024 * 1024 * 1024;
    memoryPercent = 30;
  };
}
