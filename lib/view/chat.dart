import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:night_jack/main.dart';
import 'package:night_jack/view/add_post.dart';
import 'package:night_jack/view/login.dart';

class ChatPage extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    final AsyncValue<QuerySnapshot> asyncPostsQuery = ref.watch(postsQueryProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("チャット"),
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              await Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context){
                  return LoginPage();
                }),
              );
            },
            icon: const Icon(Icons.logout)
          )
        ]
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: Text('ログイン:${user.email}'),
          ),
          Expanded(
            child: asyncPostsQuery.when(
              data: (QuerySnapshot query){
                return ListView(
                  children: query.docs.map((document) {
                    return Card(
                      child: ListTile(
                        title: Text(document['text']),
                        subtitle: Text(document['email']),
                        trailing: document['email'] == user.email
                          ? IconButton(
                            onPressed: () async{
                              await FirebaseFirestore.instance
                                .collection('posts')
                                .doc(document.id)
                                .delete();
                            }, 
                            icon: Icon(Icons.delete)
                          )
                          : null
                      ),
                    );
                  }).toList(),
                );
              }, 
              error: (e, stackTrace) {
                return Center(
                  child: Text(e.toString()),
                );
              }, 
              loading: (){
                return Center(
                  child: Text('読み込み中...'),
                );
              }
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context){
              return AddPostPage();
            })
          );
        }
      ),
    );
  }
}