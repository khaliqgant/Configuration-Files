alias deploy:staging='(cd $(dirname $(find . -name Envoy.blade.php)) && envoy run deploy:staging)'
alias deploy:production='(cd $(dirname $(find . -name Envoy.blade.php)) && envoy run deploy:production)'
