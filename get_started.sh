WORKSPACE_FILE_NAME="TossPayments-Examples.xcworkspace"

sh ./script/tuist_install.sh
sh ./script/tuist_generate.sh
sh ./script/xcode_workspace.sh

open ./${WORKSPACE_FILE_NAME}