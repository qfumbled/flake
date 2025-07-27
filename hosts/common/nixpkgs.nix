{ config, pkgs, ... }:

{
  nixpkgs.config = {
    # Allow unfree packages (e.g., proprietary software)
    allowUnfree = true;

    # List of insecure packages (only enable if necessary)
    permittedInsecurePackages = [
      "olm-3.2.16"  # Be cautious with insecure packages!
    ];
  };

  nix.settings = {
    # Specify external binary cache (only use trusted sources)
    substituters = [
      "https://nix-gaming.cachix.org"  # Be sure you trust this cache!
    ];

    # Add the public key for the cache (ensure it's the correct one)
    trusted-public-keys = [
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
    ];
  };
}
