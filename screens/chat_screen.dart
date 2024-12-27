import 'package:chat_app/components/custom_chat_bubble.dart';
import 'package:chat_app/components/custom_chat_buble_for_friend.dart';
import 'package:chat_app/constants/constans.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/screens/login_screeen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ChatScreen extends StatelessWidget {
   ChatScreen({super.key ,required this.emailId});
  @override
  var emailId;
   CollectionReference messages = FirebaseFirestore.instance.collection(kMessagesCollections);
  TextEditingController controller = TextEditingController();
    final controllerScroll = ScrollController();
  Widget build(BuildContext context) {
   // ModalRoute.of(context)!.settings.arguments;
      return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(kTime, descending: true).snapshots(),
        builder: (context,snapshot) {
          if (snapshot.hasData) {
           // print(snapshot.data!.docs);
            List<MessageModel> messageList = [];
            for(int i= 0 ; i< snapshot.data!.docs.length ; i++){
              messageList.add(MessageModel.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
              appBar: AppBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(kLogo, height: 50,),
                    Text('Chat', style: TextStyle(color: Colors.white),),
                  ],
                ),
                backgroundColor: kPrimaryColor,
                centerTitle: true,
                automaticallyImplyLeading: false,
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: controllerScroll,
                      itemCount: messageList.length,
                        itemBuilder: (context, index) {
                          return messageList[index].id == email ? ChatBuble(
                              message: messageList[index],
                          ) : ChatBubleForFriend(message: messageList[index],);
                        }
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (data) {
                        messages.add({
                          kMessage: data,
                          kTime: DateTime.now(),
                          kId: email,
                        });
                        controller.clear();
                        controllerScroll.animateTo(
                           0,
                            duration: Duration(seconds: 1,),
                            curve: Curves.easeIn,  // شكل التحرك عامل ازاي
                        );
                      },
                      decoration: InputDecoration(
                        hintText: 'Send Message',
                        suffixIcon: Icon(Icons.send),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: kPrimaryColor,
                          ),
                        ),
// enabledBorder: OutlineInputBorder(
//   borderRadius: BorderRadius.circular(16),
//   borderSide: BorderSide(
//     color: kPrimaryColor,
//   ),
// ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }else{
            return  Text("loading");
          }
        }
    );
  }
}
