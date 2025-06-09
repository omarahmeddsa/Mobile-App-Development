import 'package:flutter/material.dart';

enum Gender { man, woman }

class Yourinfo extends StatefulWidget {
  Yourinfo({super.key});

  @override
  State<Yourinfo> createState() => _YourinfoState();
}

class _YourinfoState extends State<Yourinfo> {
  Gender? _selectedgender = Gender.man;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _ageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Color.fromRGBO(52, 47, 63, 0.8),
        child: SizedBox(
          height: 100,
          width: 200,
          child: ElevatedButton(onPressed: () {}, child: Text('Finish')),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 250, left: 15, right: 15),
            child: Column(
              children: [
                Text(
                  'Tell Us About yourself',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 30),
                Text('What do you Shop for?', style: TextStyle(fontSize: 20)),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 180,
                      height: 65,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor:
                              _selectedgender == Gender.man
                                  ? Color(0xFFFFFFFF)
                                  : Colors.grey[300],
                          backgroundColor:
                              _selectedgender == Gender.man
                                  ? Color(0xFFB87FFD)
                                  : Colors.black,
                          textStyle: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _selectedgender = Gender.man;
                          });
                        },
                        child: Text('Man'),
                      ),
                    ),
                    SizedBox(
                      width: 180,
                      height: 65,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor:
                              _selectedgender == Gender.woman
                                  ? Color(0xFFFFFFFF)
                                  : Colors.white,
                          backgroundColor:
                              _selectedgender == Gender.woman
                                  ? Color(0xFFB87FFD)
                                  : Colors.black,
                          textStyle: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _selectedgender = Gender.woman;
                          });
                        },
                        child: Text('Woman'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Text('How old are you?', style: TextStyle(fontSize: 20)),
                SizedBox(height: 25),
                DropdownButtonFormField<int>(
                  key: _formKey,
                  validator: (value) {
                    if (value == null) {
                      return 'Please select your age';
                    } else {
                      return null; // Add more validation logic if needed
                    }
                  },
                  decoration: InputDecoration(labelText: 'Select Age'),
                  items:
                      List<int>.generate(60, (index) => index + 15)
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.toString()),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    setState(() {
                      _ageController.text = value.toString();
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
