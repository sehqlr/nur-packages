{ autoreconfHook, git, nodejs, python3Packages, stdenv }:

stdenv.mkDerivation rec {
  name = "mediagoblin-${version}";
  version = "stable";

  src = fetchGit {
    url = "https://git.savannah.gnu.org/git/mediagoblin.git";
    rev = "9308959be28da444e6875691fef14a635b79339d";
  };

  buildInputs = [
    autoreconfHook
    git
    nodejs
    python3Packages.python
    python3Packages.gst-python
    python3Packages.lxml
    python3Packages.pillow
    python3Packages.virtualenv
  ];

  meta = with stdenv.lib; {
    description =
      "MediaGoblin is a free software media publishing platform that anyone can run.";
    longDescription = ''
      MediaGoblin is a free software media publishing platform that anyone can run. You can think of it as a decentralized alternative to Flickr, YouTube, SoundCloud, etc.
    '';
    homepage = "https://mediagoblin.org";
    changelog =
      "https://git.savannah.gnu.org/cgit/mediagoblin.git/plain/NEWS?h=v${version}";
    license = licenses.gpl3Plus;
    maintainers = [ maintainers.sehqlr ];
    platforms = platforms.linux;
    # broken = true;
  };
}

