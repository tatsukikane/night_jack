import 'package:flutter/material.dart';
import 'package:night_jack/view/add_post.dart';
import 'package:night_jack/view/login.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("チャット"),
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              await Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context){
                  return const LoginPage();
                }),
              );
            },
            icon: const Icon(Icons.close)
          )
        ]
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context){
              return const AddPostPage();
            })
          );
        }
      ),
    );
  }
}