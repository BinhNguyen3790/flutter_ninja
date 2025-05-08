import 'package:flutter/material.dart';

class QuoteList extends StatelessWidget {
  const QuoteList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title: Text("Quote List"),
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: Text("hello"),
    );
  }
}
