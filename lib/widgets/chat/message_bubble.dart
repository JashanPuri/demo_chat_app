import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final Key key;
  final String username;
  final String imageUrl;
  MessageBubble(
    this.message,
    this.username,
    this.imageUrl,
    this.isMe, {
    this.key,
  });

  @override
  Widget build(BuildContext context) {
    final containerKey = GlobalKey();

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              key: containerKey,
              decoration: BoxDecoration(
                color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
                  bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
                ),
              ),
              // width: 140,
              constraints: BoxConstraints(maxWidth: 140),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    username == null ? '' : username,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isMe
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.headline6.color,
                    ),
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      color: isMe
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.headline6.color,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: -10,
              left: isMe ? -18 : null,
              right: isMe ? null : -18,
              child: CircleAvatar(
                backgroundImage: NetworkImage(imageUrl),
              ),
            )
          ],
          overflow: Overflow.visible,
        ),
      ],
    );
  }
}
