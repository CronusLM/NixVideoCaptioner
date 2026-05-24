{
  lib,
  buildPythonPackage,
  fetchPypi,
  pyqt5,
  pyqt5-frameless-window,
  darkdetect,
}:

buildPythonPackage rec {
  pname = "PyQt-Fluent-Widgets";
  version = "1.8.4";
  pyproject = true;

  src = fetchPypi {
    pname = "PyQt-Fluent-Widgets";
    inherit version;
    hash = "sha256-CkLxJatEBxxjhgWxFa6cnWkT+7C/Zq3WUOaUNXY7lSc=";
  };

  propagatedBuildInputs = [
    pyqt5
    pyqt5-frameless-window
    darkdetect
  ];

  # qfluentwidgets requires Qt platform to run; imports fail without display
  # pythonImportsCheck = [ "qfluentwidgets" ];

  meta = {
    description = "A fluent design widgets library based on PyQt5";
    homepage = "https://qfluentwidgets.com";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ ];
    platforms = lib.platforms.linux;
  };
}
