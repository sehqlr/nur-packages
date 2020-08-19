{ autoreconfHook, fetchgit, nodejs, python3, stdenv }:
let
  my-python-packages = python-packages: with python-packages; [
    alembic
    Babel
    bcrypt
    celery
    certifi
    configobj
    dateutil
    email_validator
    exifread
    gst-python
    itsdangerous
    jinja2
    jsonschema
    lxml
    markdown
    oauthlib
    PasteDeploy
    pasteScript
    pillow
    PyLD
    pytest
    pytest_xdist
    pytz
    requests
    six
    sphinx
    sqlalchemy
    unidecode
    virtualenv
    waitress
    webtest
    werkzeug
    wtforms
  ];
  python-with-my-packages = python3.withPackages my-python-packages;
in stdenv.mkDerivation rec {
  name = "mediagoblin-${version}";
  version = "stable";

  src = fetchgit {
    url = "https://git.savannah.gnu.org/git/mediagoblin.git";
    rev = "stable";
    sha256 = "1qbkayx3l9z6mwmgjli4rgkl369m2pzfq0wnv31l57302b05ni6f";
    fetchSubmodules = true;
  };

  buildInputs = [
    autoreconfHook
    nodejs

    python-with-my-packages
  ];

  meta = with stdenv.lib; {
    description =
      "MediaGoblin is a free software media publishing platform that anyone can run.";
    longDescription = ''
      MediaGoblin is a free software media publishing platform that
      anyone can run. You can think of it as a decentralized alternative
      to Flickr, YouTube, SoundCloud, etc.
    '';
    homepage = "https://mediagoblin.org";
    changelog =
      "https://git.savannah.gnu.org/cgit/mediagoblin.git/plain/NEWS?h=v${version}";
    license = licenses.gpl3Plus;
    maintainers = [ maintainers.sehqlr ];
    platforms = platforms.linux;
    broken = true;
  };
}

