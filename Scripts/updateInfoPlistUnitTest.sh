#!/bin/bash

SCRIPTDIR="$( cd "$( dirname "$0" )" && pwd )"

echo "Adding accountSID to plist: ${PROJECT_DIR}/UnitTests/Info.plist"
/usr/libexec/PlistBuddy -c "Set :accountSID $accountSID" $SCRIPTDIR/../UnitTests/Info.plist

echo "Adding authSID to plist: ${PROJECT_DIR}/UnitTests/Info.plist"
/usr/libexec/PlistBuddy -c "Set :authToken $authToken" $SCRIPTDIR/../UnitTests/Info.plist

echo "Adding toSMSNumber to plist: ${PROJECT_DIR}/UnitTests/Info.plist"
/usr/libexec/PlistBuddy -c "Set :toSMSNumber $toSMSNumber" $SCRIPTDIR/../UnitTests/Info.plist

