{
  lib,
  buildPythonPackage,
  fetchurl,
  pyqt5,
  pyqt5-frameless-window,
  darkdetect,
  setuptools,
}:

buildPythonPackage rec {
  pname = "pyqt-fluent-widgets";
  version = "1.8.4";
  pyproject = true;

  src = fetchurl {
    url = "https://files.pythonhosted.org/packages/source/p/pyqt-fluent-widgets/pyqt_fluent_widgets-${version}.tar.gz";
    hash = "sha256-CkLxJatEBxxjhgWxFa6cnWkT+7C/Zq3WUOaUNXY7lSc=";
  };

  nativeBuildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [
    pyqt5
    pyqt5-frameless-window
    darkdetect
  ];

  meta = {
    description = "A fluent design widgets library based on PyQt5";
    homepage = "https://qfluentwidgets.com";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ ];
    platforms = lib.platforms.linux;
  };
}
