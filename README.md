# Twilio Message

[![Build Status](https://api.travis-ci.org/Ryandev/Twilio-Message.svg)](https://travis-ci.org/Ryandev/Twilio-Message)
[![codecov](https://codecov.io/gh/Ryandev/Twilio-Message/branch/master/graph/badge.svg)](https://codecov.io/gh/Ryandev/Twilio-Message)
[![License](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/ryandev/Twilio-Message/blob/master/LICENSE)

_Twilio Message_ is an iOS app which uses the api from Twilio.com to send/receive SMS messages

This repository was created to demonstrate how to use the Twilio SMS Api & as an example of how to use MVVM, Coordinator patterns with RxSwift.

Sample Unit & UI Tests are also available to run


#### Setup Part 1. Register

1. Visit https://www.twilio.com/try-twilio
2. Register an account
3. Add funds (for sending SMS messages only)
4. Locate your 'Account SID' & 'Auth Token' from https://www.twilio.com/console


#### Setup Part 2. Run

1. Open terminal & navigate to project directory 
2. Load depdencies ```git submodule update --init --recursive```
3. Load carthage frameworks ```carthage update```


#### Setup Part 3. Test

To run Unit & UITests update ./Twilio MessageTests/Info.plist and ./Twilio MessageUITests/Info.plist with your account, auth-token, your test phone number in fields 'accountSID', 'authToken' & 'toSMSNumber'
above + Info.plist update


#### Usage

1. Login with your 'Account SID' & 'Auth Token' from the first setup stage

![login](https://github.com/RyanDev/Twilio-Message/raw/master/readme/screenshot_login.png "Login")

2. Select your account

![account](https://github.com/RyanDev/Twilio-Message/raw/master/readme/screenshot_account.png "Account")

3. Tap the compose icon in the top right corner

![messages](https://github.com/RyanDev/Twilio-Message/raw/master/readme/screenshot_messages.png "Messages")

4. Compose a message & press send

![compose](https://github.com/RyanDev/Twilio-Message/raw/master/readme/screenshot_compose.png "Compose")


#### Limitations

• User & Phone accounts cannot be created/deleted in the app


#### License

This project is licensed under the terms of the MIT license. See the [LICENSE](LICENSE) file.

> This project and all depdencies are in no way affiliated with Twilio. This project is open source under the MIT license, which means you have full access to the source code and can modify it to fit your own needs. 
