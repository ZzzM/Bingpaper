function setup() {
    GIT=`xcrun -find git`
    GIT_HASH=`${GIT} rev-parse --short HEAD`
    GIT_DATE=`${GIT} show -s --date=format:'%Y.%m.%d %k:%M' --format=%cd`
    /usr/libexec/PlistBuddy -c "Set :GIT_HASH ${GIT_HASH}" "${TARGET_BUILD_DIR}/${INFOPLIST_PATH}"
    /usr/libexec/PlistBuddy -c "Set :GIT_DATE ${GIT_DATE}" "${TARGET_BUILD_DIR}/${INFOPLIST_PATH}"
}

setup
