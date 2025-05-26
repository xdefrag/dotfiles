{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Media processing and playback
    ffmpeg
    mpv
  ];
  
  programs.mpv = {
    enable = true;
    config = {
      # Basic settings
      vo = "gpu";
      hwdec = "auto";
      
      # Audio settings
      audio-display = "no";
      
      # Subtitle settings
      sub-auto = "fuzzy";
      sub-file-paths = "subs";
      
      # Interface settings
      osc = "yes";
      osd-bar = "yes";
      
      # Performance settings
      cache = "yes";
      demuxer-max-bytes = "150MiB";
      demuxer-max-back-bytes = "75MiB";
    };
  };
} 