WORKSPACE_FILE_NAME="TossPayments-Examples.xcworkspace"

brew bundle check || brew bundle install

sh ./script/tuist_install.sh
sh ./script/tuist_generate.sh
sh ./script/xcode_workspace.sh

SKIP_EXECUTE=false

while test $# -gt 0; do
  case "$1" in
    -s|--skip-execute)
      SKIP_EXECUTE=true
      shift
      ;;
    *)
      break
      ;;
  esac
done

if [ "$SKIP_EXECUTE" = true ]; then
    open ./${WORKSPACE_FILE_NAME}
fi
