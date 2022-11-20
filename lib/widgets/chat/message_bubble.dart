import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(this.message, this.userName, this.isMe,{required this.key});

  final Key key;
  final String message;
  final String userName;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe?MainAxisAlignment.end:MainAxisAlignment.start,
      children: [
        Container(
          width: 140.0,
          padding:const EdgeInsets.symmetric(vertical: 10.0,horizontal: 16.0),
          margin: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 8.0),
          decoration: BoxDecoration(
            color: isMe?Colors.grey[300]:Theme.of(context).accentColor,
            borderRadius:BorderRadius.only(
              topLeft: const Radius.circular(14.0),
              topRight: const Radius.circular(14.0),
              bottomLeft:! isMe?const Radius.circular(0):const Radius.circular(14.0),
              bottomRight: isMe?const Radius.circular(0):const Radius.circular(14.0)
            )
          ),
          child: Column(
            crossAxisAlignment: isMe?CrossAxisAlignment.end:CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isMe?Colors.black:Theme.of(context).accentTextTheme.headline6?.color,
                ),
              ),
              Text(
                message,
                style: TextStyle(
                  color: isMe?Colors.black:Theme.of(context).accentTextTheme.headline6?.color,
                ),
                textAlign: isMe?TextAlign.end:TextAlign.start,
              ),
            ],
          ),

        )
      ],
    );
  }
}
