{ lib, pkgs, buildPythonApplication, pythonPackages
, videocaptioner-src, pyqt5-frameless-window, pyqt-fluent-widgets
, cudaSupport ? false
}:

let
  ctranslate2-cpp = if cudaSupport
    then pkgs.ctranslate2.override { withCUDA = true; }
    else pkgs.ctranslate2;

  python-ctranslate2 = pythonPackages.ctranslate2.override {
    ctranslate2-cpp = ctranslate2-cpp;
  };

  faster-whisper = pythonPackages.faster-whisper.override {
    ctranslate2 = python-ctranslate2;
  };
in

buildPythonApplication {
  pname = "videocaptioner";
  version = "0.0.0-dev";

  src = videocaptioner-src;

  pyproject = true;

  build-system = [
    pythonPackages.hatchling
    pythonPackages.hatch-vcs
  ];

  postPatch = ''
    substituteInPlace pyproject.toml --replace 'PyQt5==5.15.11' 'PyQt5>=5.15.10'
  '';

  dependencies = with pythonPackages; [
    requests
    openai
    diskcache
    yt-dlp
    json-repair
    langdetect
    pydub
    tenacity
    pillow
    fonttools
    platformdirs
    tomli
    pyqt5
    pyqt-fluent-widgets
    modelscope
    psutil
    gputil
    faster-whisper
    edge-tts
  ];

  doCheck = false;

  pythonImportsCheck = [ "videocaptioner" ];

  meta = {
    description = "AI-powered video captioning tool — ASR, subtitle optimization, translation, and synthesis";
    homepage = "https://github.com/WEIFENG2333/VideoCaptioner";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ ];
    platforms = lib.platforms.linux;
  };
}
