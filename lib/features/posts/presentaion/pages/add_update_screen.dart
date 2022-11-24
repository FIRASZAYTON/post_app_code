import '../../../../core/const/const.dart';
import '../../../../core/utils/snackBar.dart';
import '../../domin/entities/post.dart';
import 'posts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/add_update_delet_posts_bloc/add_update_delet_posts_bloc.dart';
import '../widgets/add_update_widget.dart';
import '../widgets/posts_widget/loading_posts_screen.dart';

class AddAndUpdate extends StatelessWidget {
  static String id = "AddAndUpdate";
  final Post? post;
  late bool isUpdatePost;
  AddAndUpdate({Key? key, this.post, required this.isUpdatePost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KBackGroundColorScaffold,
      appBar: AppBar(
        leading: IconButton(
          iconSize: 20,
          color: Colors.black,
          icon: Icon(
            Icons.arrow_back_ios_outlined,
          ),
          onPressed: (() => Navigator.pop(context)),
        ),
        backgroundColor: KBackGroundColorAppBar,
        title: Text(isUpdatePost ? "Edit Posts" : "add Posts",
            style: KappBarTheme),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child:
              BlocConsumer<AddUpdateDeletPostsBloc, AddUpdateDeletPostsState>(
            listener: (context, state) {
              if (state is MessageAddUpdateDeletPosts) {
                SnackBarWidget()
                    .snackBarSuccess(message: state.message, context: context);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => PostScreen()),
                    (route) => false);
              } else if (state is ErorrAddUpdateDeletPosts) {
                SnackBarWidget()
                    .snackBarErorr(message: state.message, context: context);
              }
            },
            builder: (context, state) {
              if (state is LoadingAddUpdateDeletPostsState) {
                return loadingPostsScreen();
              }
              return AddUpdateWidget(
                post: isUpdatePost ? post : null,
                isUpdatePost: isUpdatePost,
              );
            },
          ),
        ),
      ),
    );
  }
}
