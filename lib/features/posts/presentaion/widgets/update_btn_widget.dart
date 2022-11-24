import 'package:clean_architecture/core/const/const.dart';

import '../../domin/entities/post.dart';
import 'package:flutter/material.dart';

import '../pages/add_update_screen.dart';

class UpdateBtnWidget extends StatelessWidget {
  final Post post;
  const UpdateBtnWidget({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Colors.black.withOpacity(0.8))),
      onPressed: (() {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => AddAndUpdate(
                      post: post,
                      isUpdatePost: true,
                    )));
      }),
      icon: Icon(Icons.edit, color: KiconButton),
      label: Text("Edit", style: KtitleButton),
    );
  }
}
