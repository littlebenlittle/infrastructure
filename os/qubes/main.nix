with import <nixpkgs> {};

let
  # qubes_iso = fetchUrl {
  #     url = "https://mirrors.edge.kernel.org/qubes/iso/Qubes-R4.0.4-x86_64.iso";
  #     sha256 = "???";
  # };
  detached_pgp_sig = fetchUrl {
      url = "https://mirrors.edge.kernel.org/qubes/iso/Qubes-R4.0.4-x86_64.iso.asc";
      sha256 = "???";
  };
  master_signing_key = fetchUrl {
      url = "https://keys.qubes-os.org/keys/qubes-master-signing-key.asc";
      sha256 = "???";
  };
  release_signing_key = fetchUrl {
      url = "https://keys.qubes-os.org/keys/qubes-release-4-signing-key.asc";
      sha256 = "???";
  };

in
  stdenv.mkDerivation {
      builder = stdenv.shell;
      args = [
          "-e"
          "$setup"
      ];
      setup = "./setup.sh";
  }
