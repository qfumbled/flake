{
  pkgs,
  lib,
  ...
}: {
  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
    extensions = let
      createChromiumExtensionFor = browserVersion: {
        id,
        sha256,
        version,
      }: {
        inherit id;
        crxPath = builtins.fetchurl {
          url = "https://clients2.google.com/service/update2/crx?response=redirect&acceptformat=crx2,crx3&prodversion=${browserVersion}&x=id%3D${id}%26installsource%3Dondemand%26uc";
          name = "${id}.crx";
          inherit sha256;
        };
        inherit version;
      };
      createChromiumExtension = createChromiumExtensionFor (lib.versions.major pkgs.ungoogled-chromium.version);
    in [
      (createChromiumExtension {
        # ubo-lite
        id = "ddkjiahejlhfcafbddmgiahcphecmpfh";
        sha256 = "14wwibgqzf8h26vn9fpxvc2z8lxi80psb9vdwy9bv9rhl19vky83";
        version = "2025.804.1547";
      })
      # sponsorblock
      (createChromiumExtension {
        id = "mnjggcdmjocbbbhaepdhchncahnbgone";
        sha256 = "0sxkrnpn3whi21zvqhr59z74ga8h5clmh8jbqhrgncab33n4d81m";
        version = "5.14";
      })
      # pip
      (createChromiumExtension {
        id = "hkgfoiooedgoejojocmhlaklaeopbecg";
        sha256 = "0rv874709gdz15q96lr1gikx8qzg3gkyg2lrav425kzx05y8v99m";
        version = "1.14";
      })
      # allow right click
      (createChromiumExtension {
        id = "hnafhkjheookmokbkpnfpmemlppjdgoi";
        sha256 = "042p1iksvh5wy2k59h9hq67xq3i38mhzyhxdnka3rj7c2ff3bri6";
        version = "0.6.4";
      })
      # mini light theme
      (createChromiumExtension {
        id = "cfpabimfmpejjechlhcamiikffkccpgd";
        sha256 = "1wqw6nj5ld27a8vb6dvapbs9cwhvapp5dp7z1vr9ijdzmmdrq7xh";
        version = "1.3";
      })
    ];
  };
}
