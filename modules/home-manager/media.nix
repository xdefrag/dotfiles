{ pkgs, ... }: {
  programs.newsboat = {
    enable = true;
    urls = [
      {
        title = "Mises Institute";
        tags = [ "libertarianism" ];
        url = "https://mises.org/rss.xml";
      }
      {
        title = "Cato Institute";
        tags = [ "libertarianism" ];
        url = "https://www.cato.org/rss.xml";
      }
      {
        title = "Law Liberty";
        tags = ["libertarianism"];
        url = "https://lawliberty.org/category/essays/feed";
      }
      {
        title = "Students for Liberty";
        tags = ["libertarianism"];
        url = "https://studentsforliberty.org/blog/feed/";
      }
      {
        title = "The Seasteading Institute";
        tags = ["libertarianism"];
        url = "https://www.seasteading.org/news/feed/";
      }
      {
        title = "Gray Mirror";
        tags = [ "nrx" ];
        url = "https://graymirror.substack.com/feed";
      }
      {
        title = "digressionsimpressions";
        tags = [];
        url = "https://digressionsimpressions.substack.com/feed";
      }
      {
        title = "Noahpinion";
        tags = [];
        url = "https://www.noahpinion.blog/feed";
      }
      {
        title = "Humanity Redefined";
        tags = ["ai"];
        url = "https://www.humanityredefined.com/feed";
      }
      {
        title = "COINTELEGRAPH";
        tags = ["ai" "blockchain"];
        url = "https://cointelegraph.com/rss";
      }
      {
        title = "ContractsProf Blog";
        tags = ["ai""blockchain"];
        url = "https://feeds.feedburner.com/ContractsprofBlog";
      }
      {
        title = "Synced Review";
        tags = ["ai"];
        url = "https://syncedreview.com/feed/";
      }
      {
        title = "Monday Morning Haskell";
        tags = ["fp"];
        url = "https://mmhaskell.com/blog?format=RSS";
      }
      {
        title = "NixOS Newsletters";
        tags = [ "nixos" "software" ];
        url = "https://nixos.org/blog/newsletters-rss.xml";
      }
      {
        title = "NixOS Announcements";
        tags = [ "nixos" "software" ];
        url = "https://nixos.org/blog/announcements-rss.xml";
      }
      {
        title = "NixOS Stories";
        tags = [ "nixos" "software" ];
        url = "https://nixos.org/blog/stories-rss.xml";
      }
      {
        title = "Neovim News";
        tags = [ "neovim" "software" ];
        url = "https://neovim.io/news.xml";
      }
      {
        title = "Golang Weekly";
        tags = [ "golang" "software" ];
        url = "https://cprss.s3.amazonaws.com/golangweekly.com.xml";
      }
      {
        title = "Stellar Blog";
        tags = [ "stellar" "software" ];
        url = "https://stellar.org/blog/rss.xml";
      }
      {
        title = "Liberland Press";
        tags = [ "liberland" "dao" "focj" ];
        url = "https://liberlandpress.com/feed/";
      }
      {
        title = "Golang Releases";
        tags = [ "golang" "software" "github" ];
        url = "https://github.com/golang/go/releases.atom";
      }
      {
        title = "Watermill Releases";
        tags = [ "golang" "software" "github" ];
        url = "https://github.com/ThreeDotsLabs/watermill/releases.atom";
      }
      {
        title = "Lo Releases";
        tags = [ "golang" "software" "github" ];
        url = "https://github.com/samber/lo/releases.atom";
      }
      {
        title = "Nix Discourse Announcements";
        tags = ["nixos"];
        url = "https://discourse.nixos.org/c/announcements/8.rss";
      }
    ];
    extraConfig = ''
      refresh-on-startup yes
      reload-threads 100

      show-read-feeds yes
      show-read-articles yes

      color info default default reverse
      color listnormal_unread yellow default
      color listfocus blue default reverse bold
      color listfocus_unread blue default reverse bold

      text-width 80

      bind-key h quit
      bind-key j down
      bind-key k up
      bind-key l open
      bind-key H prev-feed
      bind-key L next-feed
      bind-key g home
      bind-key G end
      bind-key SPACE macro-prefix 
      bind-key b bookmark 
      bind-key ^F pagedown 
      bind-key ^B pageup 
      bind-key ^H toggle-show-read-feeds
    '';
  };
} 
