import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'ChatBody.dart';

void main() {
  runApp(
    MaterialApp(
      title: "RISP AI",
      home: Risp(),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      color: Colors.red,
    ),
  );
}

class Risp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "RISP AI".text.black.xl2.makeCentered(),
        backgroundColor: Colors.tealAccent,
        elevation: 0,
      ),
      body: ChatBody(),
    );
  }
}
