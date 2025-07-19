{...}: {
  programs.firefox = {
    enable = true;

    profiles."user" = {
      id = 0;
      isDefault = true;

      settings = {
        "sidebar.verticalTabs" = true;
      };

      search = {
        default = "brave";

        engines = {
          brave = {
            name = "brave";
            urls = [
              {
                template = "https://search.brave.com/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };
        };
      };
    };
  };
}
