import '../../../../core/const/const.dart';
import '../../domin/entities/post.dart';
import 'update_btn_widget.dart';
import 'package:flutter/material.dart';

import '../pages/delet_screen.dart';

class PostsDetailsWidget extends StatelessWidget {
  final Post post;
  const PostsDetailsWidget({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(children: [
        Text(
          post.title,
          style: KtitleTheme,
        ),
        Divider(
          thickness: 1,
          height: 50,
        ),
        Text(
          post.body,
          style: KsubTitleTheme,
        ),
        Divider(
          thickness: 1,
          height: 50,
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            UpdateBtnWidget(
              post: post,
            ),
            DeletScreen(post: post),
          ],
        )
      ]),
    );
  }
}
