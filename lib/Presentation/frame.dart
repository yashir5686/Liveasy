import 'package:flutter/material.dart';
import 'package:liveasy/Presentation/login_page.dart';

class Frame extends StatefulWidget {
  const Frame({super.key, required this.title});

  final String title;

  @override
  State<Frame> createState() => _FrameState();
}

class _FrameState extends State<Frame> {
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Liveasy',
              style: TextStyle(fontSize: 30.0),
            ),
            //Image.asset('assets/flutter_logo.png'),
            const SizedBox(height: 20.0),
            const Text(
              'Please select your Language',
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'You can change the language at any time.',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 20.0),
            DropdownButtonFormField<String>(
              value: selectedLanguage,
              isExpanded: true,
              padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
              style: const TextStyle(fontSize: 20, color: Colors.grey),
              onChanged: (language) {
                setState(() {
                  selectedLanguage = language as String;
                });
              },
              items: <String>['English', 'Spanish', 'French', 'Hindi']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: const InputDecoration(
                  labelText: 'language',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2, color: Color.fromARGB(178, 97, 98, 98)),
                  )),
            ),
            const SizedBox(height: 20.0),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const PhoneNumberPage()));
              },
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                margin: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                height: 50,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(60, 81, 145, 1),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Next',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
