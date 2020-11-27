import 'package:flutter/material.dart';
import 'package:risp/askrisp.dart';
import 'package:risp/conversations.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:async';

class ChatBody extends StatefulWidget {
  @override
  _ChatBodyState createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  final _textController = new TextEditingController();

  List messages = [
    {
      "message":
          "Hey there, This is RISP, your personal AI assistant. How can I help you",
      "time": "12:00",
      "user": "false"
    }
  ];

  void _askrisp() async {
    var query = _textController.text;
    if (query == "") {
      return;
    }
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm').format(now);
    var tempo = {
      "message": query,
      "time": formattedDate,
      "user": "true",
    };

    var wait = {
      "message": "waiting",
      "time": formattedDate,
      "user": "false",
    };
    _textController.clear();
    setState(() {
      messages.add(tempo);
      messages.add(wait);
    });
    String result = await askRisp().question(query);
    DateTime nowagain = DateTime.now();
    String formattedDateagain = DateFormat('kk:mm').format(nowagain);
    var tempr = {
      "message": result,
      "time": formattedDateagain,
      "user": "false",
    };
    setState(() {
      messages.remove(wait);
      messages.add(tempr);
    });
  }

  Widget _textArea() {
    return Row(
      children: [
        Flexible(
          child: Padding(
            padding: EdgeInsets.only(left: 10),
            child: TextField(
              style: TextStyle(
                fontSize: 18,
              ),
              controller: _textController,
              decoration: InputDecoration.collapsed(
                  hintText: "Ask a query..",
                  hintStyle: TextStyle(
                    color: Colors.black12,
                  )),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          child: IconButton(
            icon: Icon(Icons.send),
            onPressed: () => _askrisp(),
          ),
        ),
      ],
    ).box.gray200.p3.roundedLg.make();
  }

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
        ),
        child: Column(children: [
          Expanded(
              child: Messages(
            messages: messages,
          )),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: _textArea()),
          SizedBox(
            width: 10,
          ),
        ])).box.teal500.shadow.make();
  }
}
