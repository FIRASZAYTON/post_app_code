import '../../../../core/const/const.dart';
import '../../domin/entities/post.dart';
import 'package:flutter/material.dart';

import '../widgets/posts_details_widget.dart';

class PostsDetailScreen extends StatelessWidget {
  final Post post;

  const PostsDetailScreen({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context),
      body: _buildBody(),
    );
  }

  AppBar appBarWidget(BuildContext context) => AppBar(
        leading: IconButton(
          iconSize: 20,
          color: Colors.black,
          icon: Icon(
            Icons.arrow_back_ios_outlined,
          ),
          onPressed: (() => Navigator.pop(context)),
        ),
        title: Text(
          "Posts Details",
          style: KappBarTheme,
        ),
        backgroundColor: KBackGroundColorAppBar,
      );

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: PostsDetailsWidget(
          post: post,
        ),
      ),
    );
  }
}
