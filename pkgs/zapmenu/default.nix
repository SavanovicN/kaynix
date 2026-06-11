{
  lib,
  stdenvNoCC,
  fetchurl,
}: let
  version = "1.0.1";

  sources = {
    aarch64-darwin = {
      arch = "aarch64";
      hash = "sha256-fqrV8DeiFS7+j6Cc5iZ6JdN9ktzY5PUBfaicNvGW8G0=";
    };
    x86_64-darwin = {
      arch = "x86_64";
      hash = "sha256-IO1a9ImJ2RA4cuFE7MrUOsOyL7tUk0svm9VUBgbQKAI=";
    };
  };

  src = sources.${stdenvNoCC.hostPlatform.system} or (throw "zapmenu: macOS only (${stdenvNoCC.hostPlatform.system})");
in
  stdenvNoCC.mkDerivation {
    pname = "zapmenu";
    inherit version;

    src = fetchurl {
      url = "https://github.com/kaynetik/zapmenu/releases/download/v${version}/zapmenu-v${version}-${src.arch}-macos.tar.gz";
      inherit (src) hash;
    };

    # The release tarball contains only the bare binary, no top-level directory.
    sourceRoot = ".";

    dontBuild = true;

    installPhase = ''
      runHook preInstall
      install -Dm755 zapmenu $out/bin/zapmenu
      runHook postInstall
    '';

    meta = with lib; {
      description = "Block the macOS auto-hide menu bar from appearing at the top of the screen";
      homepage = "https://github.com/kaynetik/zapmenu";
      license = licenses.mit;
      mainProgram = "zapmenu";
      platforms = builtins.attrNames sources;
      sourceProvenance = [sourceTypes.binaryNativeCode];
    };
  }
