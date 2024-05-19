import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liveasy/Presentation/profile_selection.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key, required this.phNumber});
  final String phNumber;

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificationId;
  String verificationcode = '';
  Timer? _timer;
  int _start = 30; // Countdown duration in seconds
  bool _isResendAvailable = false;
  final FocusNode _otpFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _verifyPhoneNumber();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpFocusNode.dispose();
    super.dispose();
  }

  void _unfocusAll() {
    _otpFocusNode.unfocus();
  }

  void startTimer() {
    setState(() {
      _start = 30;
      _isResendAvailable = false;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _isResendAvailable = true;
        });
        _timer?.cancel();
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _unfocusAll,
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 24),
                const Text(
                  'Verify Phone',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Code is sent to ${widget.phNumber}",
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 16),
                Focus(
                    focusNode: _otpFocusNode,
                    child: Builder(builder: (context) {
                      return OtpPinField(
                        onSubmit: (otp) {
                          setState(() {
                            verificationcode = otp;
                          });
                        },
                        onChange: (otp) {
                          setState(() {
                            verificationcode = otp;
                          });
                        },
                        onCodeChanged: (otp) {
                          setState(() {
                            verificationcode = otp;
                          });
                        },
                        autoFillEnable: false,
                        autoFocus: false,
                        textInputAction: TextInputAction.done,
                        maxLength: 6,
                        fieldWidth: MediaQuery.of(context).size.width / 9,
                        otpPinFieldDecoration:
                            OtpPinFieldDecoration.defaultPinBoxDecoration,
                      );
                    })),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Didn't receive the code?",
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_isResendAvailable) {
                          _verifyPhoneNumber();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'Wait for $_start seconds before Requesting OTP again!!')));
                        }
                      },
                      child: const Text(
                        "Request Again",
                        style:
                            TextStyle(color: Color.fromARGB(255, 45, 61, 69)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    //formKey.currentState?.save();
                    _signInWithPhoneNumber();
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                      backgroundColor: const Color.fromRGBO(60, 81, 145, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2))),
                  child: const Text(
                    'VERIFY AND CONTINUE',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _verifyPhoneNumber() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: widget.phNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-retrieval or instant validation
        if (verificationcode == '') {
          setState(() {
            verificationcode == credential.smsCode;
          });
        }
        await _auth.signInWithCredential(credential);

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => const ProfileSelection()));
      },
      verificationFailed: (FirebaseAuthException e) {
        // Handle the error here
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.message ?? 'Verification failed')));
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _verificationId = verificationId;
        });
        startTimer();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          _verificationId = verificationId;
        });
      },
    );
  }

  void _signInWithPhoneNumber() async {
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: verificationcode,
      );

      final User? user = (await _auth.signInWithCredential(credential)).user;

      if (user != null) {
        // Successful sign-in
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Successfully signed in')));

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => const ProfileSelection()));
      }
    } catch (e) {
      // sign-in Failed
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to sign in: $e')));
    }
  }
}
