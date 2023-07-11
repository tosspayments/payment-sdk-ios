ROOT_PATH=$(cd `dirname $0`/.. && pwd)
WORKSPACE_PATH="${ROOT_PATH}/Examples/TossPayments-Examples"
WORKSPACE_FILE_NAME="TossPayments-Examples.xcworkspace"


pushd $ROOT_PATH

echo "${WORKSPACE_PATH}/${WORKSPACE_FILE_NAME}"

# make symbolic link
ln -sf "${WORKSPACE_PATH}/${WORKSPACE_FILE_NAME}" ${WORKSPACE_FILE_NAME}

popd