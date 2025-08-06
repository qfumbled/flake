{ pkgs, ... }: {
  hardware = {
    bluetooth = {
      enable = true;
      input.General = {
        ClassicBondedOnly = false;
      };
      settings = {
        General = {
          Experimental = true;
          FastConnectable = true;
          powerOnBoot = true;
          JustWorksRepairing = "always";
          Privacy = "device";
        };
      };
    };
    brillo.enable = true;
  };

  boot.extraModprobeConfig = ''options bluetooth disable_ertm=1 '';
  systemd.user.services.telephony_client.enable = false;
}
