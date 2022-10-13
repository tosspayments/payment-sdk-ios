ROOT_PATH=$(cd `dirname $0`/.. && pwd)

# Alias
TUIST_BINARY="tuist"
if [[ -f "$ROOT_PATH/.tuist-bin/tuist" ]]; then
    TUIST_BINARY="$ROOT_PATH/.tuist-bin/tuist"
fi

pushd $ROOT_PATH/Examples/TossPayments-Examples
tuist generate -n 
popd 