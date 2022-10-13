ROOT_PATH=$(cd `dirname $0`/.. && pwd)

# Tuist
echo $'\n'"▸ Install tuist"
TUIST_VERSION=$(cat .tuist-version)
if [[ -f ".tuist-bin/.tuist-version.lock" ]]; then
    INSTALLED_TUIST_VERSION=$(cat ".tuist-bin/.tuist-version.lock")
else
    INSTALLED_TUIST_VERSION=""
fi

if [ "$TUIST_VERSION" != "$INSTALLED_TUIST_VERSION" ]; then
    mkdir -p "$HOME/.tuist/Cache/Download"
    TUIST_DOWNLOADED_FILE="$HOME/.tuist/Cache/Download/${TUIST_VERSION}.zip"
    if [[ ! -f "$TUIST_DOWNLOADED_FILE" ]]; then
        {
            curl -L -o "$TUIST_DOWNLOADED_FILE" "https://github.com/tuist/tuist/releases/download/${TUIST_VERSION}/tuist.zip"
        } || {
            rm "$TUIST_DOWNLOADED_FILE"
        }
    fi
    unzip -o "$TUIST_DOWNLOADED_FILE" -d .tuist-bin

    echo $TUIST_VERSION > .tuist-bin/.tuist-version.lock
fi
