PYTHON_VERSION="${PYTHON_VERSION:=3.7.10}"

$dry pyenv install $PYTHON_VERSION
$dry pynenv global $PYTHON_VERSION
