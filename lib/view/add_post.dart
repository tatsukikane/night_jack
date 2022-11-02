import 'package:flutter/material.dart';

class AddPostPage extends StatelessWidget {
  const AddPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("チャット投稿"),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("戻る"),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}