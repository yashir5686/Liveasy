import 'package:flutter/material.dart';
import 'package:liveasy/Presentation/frame.dart';

class ProfileSelection extends StatefulWidget {
  const ProfileSelection({super.key});

  @override
  State<ProfileSelection> createState() => _ProfileSelectionState();
}

class _ProfileSelectionState extends State<ProfileSelection> {
  String selectedProfile = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Please select your profile',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedProfile = 'Shipper';
                });
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                decoration: BoxDecoration(
                    border: BoxBorder.lerp(
                        Border.all(width: 1), Border.all(width: 1), 0)),
                child: ListTile(
                  title: Row(
                    children: [
                      Image.asset('assets/shipper.png', width: 40, height: 40),
                      const SizedBox(width: 10),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Shipper',
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            'Lorem ipsum dolor sit amet, \nconsectetur adipiscing',
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          )
                        ],
                      )
                    ],
                  ),
                  leading: Radio(
                    value: selectedProfile == 'Shipper' ? 1 : 0,
                    groupValue: 1,
                    onChanged: (value) {
                      setState(() {
                        selectedProfile = 'Shipper';
                      });
                    },
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedProfile = 'Transporter';
                });
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                decoration: BoxDecoration(
                    border: BoxBorder.lerp(
                        Border.all(width: 1), Border.all(width: 1), 0)),
                child: ListTile(
                  title: Row(
                    children: [
                      Image.asset('assets/transpoter.png',
                          width: 40, height: 40),
                      const SizedBox(width: 10),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Transporter',
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            'Lorem ipsum dolor sit amet, \nconsectetur adipiscing',
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          )
                        ],
                      )
                    ],
                  ),
                  leading: Radio(
                    value: selectedProfile == 'Transporter' ? 1 : 0,
                    groupValue: 1,
                    onChanged: (value) {
                      setState(() {
                        selectedProfile = 'Transporter';
                      });
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const Frame(title: 'Liveasy')));
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                    backgroundColor: const Color.fromRGBO(60, 81, 145, 1),
                    padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2))),
                child: const Text(
                  'VERIFY AND CONTINUE',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
