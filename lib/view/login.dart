import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:night_jack/main.dart';
import 'package:night_jack/view/chat.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class LoginPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context,  WidgetRef ref) {

  final  infoText = ref.watch(infoTextProvider);
  final  email = ref.watch(emailProvider);
  final  password = ref.watch(passwordProvider);

    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: "メールアドレス"),
                onChanged: (String value) {
                  ref.read(emailProvider.notifier).state = value;
                }
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'パスワード'),
                obscureText: true,
                onChanged: (String value){
                  ref.read(passwordProvider.notifier).state = value;
                },
              ),
              Container(
                padding: EdgeInsets.all(8),
                child: Text(infoText),
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text("ユーザー登録"),
                  onPressed: () async {
                    try{
                      final FirebaseAuth auth = FirebaseAuth.instance;
                      final result = await auth.createUserWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      await Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context){
                          return ChatPage();
                        }),
                      );
                    } catch (e) {
                      ref.read(infoTextProvider.notifier).state = "登録に失敗しました:${e.toString()}";
                    }
                  },
                ),
              ),
              const SizedBox(height: 8,),
              Container(
                width: double.infinity,
                child: OutlinedButton(
                  child: Text("ログイン"),
                  onPressed: () async {
                    try {
                      final FirebaseAuth auth = FirebaseAuth.instance;
                      final result = await auth.signInWithEmailAndPassword(
                        email: email, 
                        password: password
                      );
                      await Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context){
                          return ChatPage();
                        }),
                      );
                    } catch (e) {
                      ref.read(infoTextProvider.notifier).state = "ログインに失敗しました：${e.toString()}";
                    }
                  },
                ),
              )
            ]
          ),
        ),
      ),
    );
  }
}