{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.opt.tpm2;
in {
  options.opt.tpm2 = {
    enable = mkEnableOption "TPM2 security settings";
  };

  config = mkIf cfg.enable {
    security.tpm2.enable = true;
    security.tpm2.pkcs11.enable = true;
    security.tpm2.tctiEnvironment.enable = true;
    users.users.monaco.extraGroups = ["tss"];
  };
}
