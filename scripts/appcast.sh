function generate_changlog() {
    local changelog=`cat changelogs/CHANGELOG_SC.md`
    changelog=${changelog%%---*}
    changelog=${changelog#*###}
    changelog="###$changelog"
    echo "$changelog" > $FIR_APP_CHANGELOG
}

function clean() {
    rm -vfr ~/Library/Developer/Xcode/Archives/*
}

function upload() {
    fastlane fir_cli
}

generate_changlog
upload
clean
