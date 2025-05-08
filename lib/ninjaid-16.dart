import 'package:flutter/material.dart';

class NinjaId extends StatefulWidget {
  const NinjaId({super.key});

  @override
  State<NinjaId> createState() => _NinjaIdState();
}

class _NinjaIdState extends State<NinjaId> {
  int level = 0;

  Color bgColor = Colors.grey[900]!;

  void handleLevel() {
    setState(() {
      level++;
      print("handle level: $level");
      // change color
      bgColor =
          bgColor == Colors.grey[900] ? Colors.grey[800]! : Colors.grey[900]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(
          "Ninja ID Card",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
        elevation: 0.0,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/img/thumb.jpg"),
                radius: 40,
              ),
            ),
            Divider(height: 60, color: Colors.grey[700]),
            Text(
              "Name",
              style: TextStyle(color: Colors.grey, letterSpacing: 2),
            ),
            SizedBox(height: 10),
            Text(
              "Chun-li",
              style: TextStyle(
                color: Colors.amberAccent[200],
                letterSpacing: 2,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            Text(
              "Current Ninja Level",
              style: TextStyle(color: Colors.grey, letterSpacing: 2),
            ),
            SizedBox(height: 10),
            Text(
              "$level",
              style: TextStyle(
                color: Colors.amberAccent[200],
                letterSpacing: 2,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Icon(Icons.email, color: Colors.grey[400]),
                SizedBox(width: 10),
                Text(
                  "chun.li@ninjaidcard.com",
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 18,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[800],
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: handleLevel,
        child: Icon(Icons.add),
      ),
    );
  }
}
