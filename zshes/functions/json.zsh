# depends on the most excellent jq library
# https://stedolan.github.io/jq/
function validate() {
    pbpaste | jq '.' $@
}

function copyJson() {
    pbpaste | jq '.' $@ | pbcopy
}

function copyFile() {
    cat $@ | pbcopy
}

# leverages https://github.com/simeji/jid
function filter() {
    pbpaste | jid | jq '.'
}

function minify() {
    pbpaste | jq -c '.' $@ | pbcopy
}

# leverages https://github.com/antonmedv/fx
function inspect() {
    pbpaste | fx
}

function getJson() {
    curl -s $@ | fx
}
