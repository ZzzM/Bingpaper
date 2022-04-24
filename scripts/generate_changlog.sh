
# function read_mobileprovision() {
#     local certificate_path=$RUNNER_TEMP/$APP_NAME.p12
#     local pp_path=$RUNNER_TEMP/$APP_NAME.mobileprovision
#     local pp_ne_path=$RUNNER_TEMP/${APP_NAME}_NE.mobileprovision

#     echo -n $CERTIFICATE_DATA | base64 --decode --output $certificate_path
#     echo -n $ALPHA_PROFILE_DATA | base64 --decode --output $pp_path
#     echo -n $ALPHA_NE_PROFILE_DATA | base64 --decode --output $pp_ne_path

#     echo "CERTIFICATE_PATH=$certificate_path" >> $GITHUB_ENV
#     echo "PP_PATH=$pp_path" >> $GITHUB_ENV
#     echo "PP_NE_PATH=$pp_ne_path" >> $GITHUB_ENV
# }

function generate_changlog() {
    local changelog=`cat changelogs/CHANGELOG_SC.md`
    changelog=${changelog%%---*}
    changelog=${changelog#*###}
    changelog="###$changelog"
    echo "$changelog" > $FIR_APP_CHANGELOG
}


generate_changlog