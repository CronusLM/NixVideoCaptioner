{
  lib,
  buildPythonPackage,
  fetchPypi,
  pyqt5,
  xcffib,
}:

buildPythonPackage rec {
  pname = "PyQt5-Frameless-Window";
  version = "0.8.1";
  pyproject = true;

  src = fetchPypi {
    pname = "PyQt5-Frameless-Window";
    inherit version;
    hash = "sha256-ZdJ+9kHfpq/Yz5FNkUyG3Mv7bR8b9BfRXhYZbCMoX6k=";
  };

  propagatedBuildInputs = [
    pyqt5
    xcffib
  ];

  pythonImportsCheck = [ "PyQt5.FramelessWindow" ];

  meta = {
    description = "A frameless window widget for PyQt5";
    homepage = "https://github.com/zhiyiYo/PyQt5-Frameless-Window";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ ];
    platforms = lib.platforms.linux;
  };
}
