import 'package:flutter/material.dart';
import 'package:night_jack/view/chat.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async{
                await Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context){
                    return const ChatPage();
                  }),
                );
              }, 
              child: const Text("ログイン")
            )
          ]
        ),
      ),
    );
  }
}