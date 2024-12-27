import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';

class ChatBubleForFriend extends StatelessWidget {
  ChatBubleForFriend({super.key,required this.message});
  final MessageModel message;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
             // bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(message.message,style: TextStyle(color: Colors.white),),
          ),
        ),
      ),
    );
  }
}
