import '../../../../core/const/const.dart';
import '../widgets/shimmer_widget/shimmer_posts.dart';
import 'add_update_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/posts/posts_bloc.dart';
import '../widgets/posts_widget/erorr_posts_screen.dart';
import '../widgets/posts_widget/loaded_posts_screen.dart';

class PostScreen extends StatelessWidget {
  static String id = "PostScreen";
  const PostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KBackGroundColorScaffold,
      appBar: _appBar(),
      body: _buildBody(),
      floatingActionButton: _floatingActionButtonAnimator(context),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is LoadingPostsState) {
            return ShimmerPosts();
          } else if (state is LoadedPostsState) {
            return RefreshIndicator(
                onRefresh: (() => _refresh(context)),
                child: loadedPostsScreen(posts: state.posts));
          } else if (state is ErorrPostsState) {
            return ErrorPostsScreen(
              message: state.message,
            );
          }
          return ShimmerPosts();
        },
      ),
    );
  }

  AppBar _appBar() => AppBar(
      elevation: 3,
      backgroundColor: KBackGroundColorAppBar,
      titleTextStyle: KappBarTheme,
      // centerTitle: true,/
      title: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Text("Posts "),
      ));
  FloatingActionButton _floatingActionButtonAnimator(BuildContext context) {
    return FloatingActionButton(
      elevation: 2,
      backgroundColor: Colors.black54,
      onPressed: (() {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => AddAndUpdate(
                      isUpdatePost: false,
                    )));
      }),
      child: Icon(Icons.add),
    );
  }

  Future<void> _refresh(BuildContext context) async {
    BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvents());
  }
}
