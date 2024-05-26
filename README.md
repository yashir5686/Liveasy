# liveasy

A Flutter App Basically Containing only 4 Pages, The Main theme of the app is to build a phone authentication system.

# App Overview:
The "Liveasy" app primarily focuses on phone number authentication using Firebase Authentication. It consists of four main pages:

1. Language Selection Page: Users can select their preferred language for the app's interface.
2. Phone Number Input Page: Users input their phone numbers, initiating the authentication process.
3. OTP Page: After entering the phone number, users receive an OTP (One-Time Password) for verification. This page allows users to input the received OTP.
4. Profile Selection Page: Upon successful authentication, users are directed to a profile selection page.

This app uses Firebase Authentication for Phone authentication.

# Technology Stack:

• Flutter: The app is built using the Flutter framework, enabling cross-platform development for iOS and Android.

• Firebase Authentication: Firebase Authentication is utilized for phone number authentication, enabling users to sign in securely using their phone numbers.

# Plugins Used:

• Firebase Core(firebase_core): This plugin provides the necessary functionality to communicate with Firebase services, including Authentication and Firestore.

• Firebase Auth: Specifically for Firebase Authentication, this plugin facilitates phone number authentication, OTP verification, and user management.

• Intl Phone Field(intl_phone_field): This plugin is used To Make the phone number field which supports phone number validation and multiple country picker.

• OTP Text Field(flutter_otp_text_field): This plugin is used to create a customizable OTP input field, simplifying the user verification process during phone number authentication.

Overall, the app aims to provide a seamless and secure authentication experience for users through phone number verification, leveraging the capabilities of Firebase Authentication within the Flutter framework.
