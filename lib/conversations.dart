import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:velocity_x/velocity_x.dart';

class Messages extends StatefulWidget {
  final List messages;
  bool scroll;
  Messages({@required this.messages, this.scroll});
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  ScrollController _controller = ScrollController();
  void _scrollToEnd() async {
    WidgetsBinding.instance.addPostFrameCallback((_) => Timer(
        Duration(milliseconds: 500),
        () => _controller.jumpTo(_controller.position.maxScrollExtent)));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.scroll == true) {
      _scrollToEnd();
      widget.scroll = false;
    }
    return Container(
        width: MediaQuery.of(context).size.width,
        color: Vx.teal300,
        child: ListView.builder(
          controller: _controller,
          physics: BouncingScrollPhysics(),
          itemCount: widget.messages.length,
          itemBuilder: (context, index) => chatUnit(
              context,
              widget.messages[index]['message'],
              widget.messages[index]['time'],
              widget.messages[index]['user']),
        ));

    Timer(Duration(milliseconds: 500),
        () => _controller.jumpTo(_controller.position.maxScrollExtent));
  }
}

Widget chatUnit(
    BuildContext context, String message, String datetime, var user) {
  Color rajat = user == "true" ? Vx.red300 : Vx.blue300;
  return Align(
    alignment: user == "true" ? Alignment.topRight : Alignment.topLeft,
    child: Container(
            decoration: BoxDecoration(
              color: rajat,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Container(
                    alignment: Alignment.topLeft,
                    child: message == "waiting"
                        ? SpinKitThreeBounce(
                            color: Colors.red[300],
                            size: 30.0,
                          )
                        : message.text.white.xl
                            .overflow(TextOverflow.ellipsis)
                            .maxLines(100)
                            .make()),
                datetime.text.gray300.thin.make().box.alignBottomRight.make(),
              ],
            ))
        .box
        .width(MediaQuery.of(context).size.width * 0.5)
        .margin(EdgeInsets.all(10))
        .rounded
        .make(),
  );
}
