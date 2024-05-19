import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:liveasy/Presentation/otp_page.dart';

class PhoneNumberPage extends StatefulWidget {
  const PhoneNumberPage({super.key});

  @override
  _PhoneNumberPageState createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  String initialCountry = 'IN';
  bool ischecked = false;
  bool iserror = false;
  String phonenumber = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              const Text(
                'Please Enter Your Mobile Number',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text(
                "You'll recieve a 6 digit code",
                style: TextStyle(color: Colors.grey),
              ),
              const Text(
                'to verify next.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              Form(
                key: formKey,
                child: IntlPhoneField(
                  keyboardType: TextInputType.phone,
                  //showDropdownIcon: true,
                  initialCountryCode: 'IN',
                  onSaved: (phonenumber) {
                    formKey.currentState?.validate();
                    if (phonenumber!.number.isNotEmpty &&
                        formKey.currentState?.validate() == true &&
                        iserror == false) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => OtpPage(
                                    phNumber: phonenumber.completeNumber,
                                  )));
                    } else {
                      setState(() {
                        if (ischecked == false) {
                          iserror = true;
                        }
                      });
                    }
                  },
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  formKey.currentState?.save();
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                    backgroundColor: const Color.fromRGBO(60, 81, 145, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2))),
                child: const Text(
                  'CONTINUE',
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
    );
  }
}
