import 'package:flutter/material.dart';

class PostsFeed extends StatelessWidget {
  const PostsFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Snappio")),
      body: const Center(
        child: Text("This is the posts feed page"),
      ),
    );
  }
}
