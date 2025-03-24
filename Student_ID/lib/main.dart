import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: StudentID()));
}

class StudentID extends StatefulWidget {
  const StudentID({super.key});

  @override
  State<StudentID> createState() => _StudentIDState();
}

class _StudentIDState extends State<StudentID> {
  @override
  int StudentLevel = 0;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(
          'Student ID Card',
          style: TextStyle(color: Colors.white60, fontSize: 30),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[800],
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (StudentLevel>=30){
              StudentLevel = 0 ;
            }
            StudentLevel++;
          });
        },
        backgroundColor: Colors.grey[800],
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(40, 30, 30, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/Img_1.jpg'),
                radius: 50,
              ),
            ),
            Divider(height: 60, color: Colors.grey),
            SizedBox(height: 10),
            Text(
              'NAME',
              style: TextStyle(
                color: Colors.white60,
                fontSize: 20,
                letterSpacing: 2,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Chun-Li',
              style: TextStyle(
                color: Colors.amberAccent,
                fontSize: 28,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Current Student Level',
              style: TextStyle(
                color: Colors.white60,
                fontSize: 20,
                letterSpacing: 2,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '$StudentLevel',
              style: TextStyle(
                color: Colors.amberAccent,
                fontSize: 28,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            Row(
              children: <Widget>[
                Icon(Icons.email, color: Colors.white60),
                SizedBox(width: 10),
                Text(
                  'Chun-Li@gmail.com',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
