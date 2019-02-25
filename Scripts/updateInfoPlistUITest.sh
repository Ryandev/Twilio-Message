#!/bin/bash

SCRIPTDIR="$( cd "$( dirname "$0" )" && pwd )"

echo "Adding accountSID to plist: ${PROJECT_DIR}/UnitTests/Info.plist"
/usr/libexec/PlistBuddy -c "Set :accountSID $accountSID" $SCRIPTDIR/../UITests/Info.plist

echo "Adding authSID to plist: ${PROJECT_DIR}/UnitTests/Info.plist"
/usr/libexec/PlistBuddy -c "Set :authToken $authToken" $SCRIPTDIR/../UITests/Info.plist
