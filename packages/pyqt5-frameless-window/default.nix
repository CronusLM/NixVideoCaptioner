{
  lib,
  buildPythonPackage,
  fetchurl,
  pyqt5,
  xcffib,
  setuptools,
}:

buildPythonPackage rec {
  pname = "pyqt5-frameless-window";
  version = "0.8.1";
  pyproject = true;

  src = fetchurl {
    url = "https://files.pythonhosted.org/packages/source/P/PyQt5-Frameless-Window/pyqt5_frameless_window-${version}.tar.gz";
    hash = "sha256-QS7yC82ExhSv/a5GoRs2B1rzSR17gt9uG/6OinCMJKw=";
  };

  nativeBuildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [
    pyqt5
    xcffib
  ];

  postPatch = ''
    python3 -c "
import re
with open('qframelesswindow/utils/linux_utils.py', 'r') as f:
    content = f.read()
content = content.replace(
    'from PyQt5.QtX11Extras import QX11Info',
    '''try:
    from PyQt5.QtX11Extras import QX11Info
except ImportError:
    class QX11Info:
        @staticmethod
        def isPlatformX11():
            return False'''
)
with open('qframelesswindow/utils/linux_utils.py', 'w') as f:
    f.write(content)
"
  '';

  # import check skipped: importing qframelesswindow triggers PyQt5.QtX11Extras which is absent in nixpkgs

  meta = {
    description = "A frameless window widget for PyQt5";
    homepage = "https://github.com/zhiyiYo/PyQt5-Frameless-Window";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ ];
    platforms = lib.platforms.linux;
  };
}
