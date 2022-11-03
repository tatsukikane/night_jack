import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:night_jack/view/login.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

//ユーザー情報の受け渡しを行う為のProvider
final userProvider = StateProvider((ref) {
  return FirebaseAuth.instance.currentUser;
});

// エラー情報の受け渡しを行うためのProvider
// ※ autoDisposeを付けることで自動的に値をリセットできます
final infoTextProvider = StateProvider.autoDispose((ref){
  return '';
});

//メールアドレスの受け渡しを行う為のProvider
final emailProvider = StateProvider.autoDispose((ref){
  return '';
});

// パスワードの受け渡しを行うためのProvider
final passwordProvider = StateProvider.autoDispose((ref){
  return '';
});

// メッセージの受け渡しを行うためのProvider
final messageTextProvider = StateProvider.autoDispose((ref){
  return '';
});

//投稿一覧取得のためのProvider
// StreamProviderを使うことでStreamも扱うことができる
final postsQueryProvider = StreamProvider.autoDispose((ref){
  return FirebaseFirestore.instance
    .collection('posts')
    .orderBy('date')
    .snapshots();
});



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ProviderScope(child: const NightJack())
  );
}

class NightJack extends StatelessWidget {
  const NightJack({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NightJack',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}