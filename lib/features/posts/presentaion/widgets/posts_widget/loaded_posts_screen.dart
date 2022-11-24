import 'package:clean_architecture/core/const/const.dart';

import '../../../domin/entities/post.dart';
import '../../pages/posts_details_screen.dart';

import 'package:flutter/material.dart';

class loadedPostsScreen extends StatelessWidget {
  final List<Post> posts;
  const loadedPostsScreen({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, int index) {
          return Card(
            elevation: 2,
            shadowColor: Colors.grey.shade400,

            // shadowColor: Colors.grey.shade200,
            color: KBackGroundColorAppBar,
            child: ListTile(
              horizontalTitleGap: 5,
              isThreeLine: true,
              leading: Text(
                posts[index].id.toString(),
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.w800),
              ),
              title: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(posts[index].title, style: KtitleTheme),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
                child: Text(
                  posts[index].body,
                  style: KsubTitleTheme,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 15,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostsDetailScreen(
                      post: posts[index],
                    ),
                  ),
                );
              },
            ),
          );
        },
        separatorBuilder: (context, int) => Divider(
              color: Colors.grey.shade300,
              thickness: 1,
            ),
        itemCount: posts.length);
  }
}
