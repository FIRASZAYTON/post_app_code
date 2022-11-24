import 'package:clean_architecture/core/const/const.dart';

import '../../domin/entities/post.dart';
import 'posts_screen.dart';
import '../widgets/delet_dialog_widget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/snackBar.dart';
import '../bloc/add_update_delet_posts_bloc/add_update_delet_posts_bloc.dart';
import '../widgets/posts_widget/loading_posts_screen.dart';

class DeletScreen extends StatelessWidget {
  final Post post;
  const DeletScreen({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ElevatedButton.icon(
        style:
            ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
        onPressed: (() {
          deletDilog(context);
        }),
        icon: Icon(
          Icons.delete,
          color: KiconButton,
        ),
        label: Text(
          "Delet",
          style: KtitleButton,
        ),
      ),
    );
  }

  void deletDilog(
    BuildContext context,
  ) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<AddUpdateDeletPostsBloc,
              AddUpdateDeletPostsState>(
            listener: (context, state) {
              if (state is MessageAddUpdateDeletPosts) {
                SnackBarWidget()
                    .snackBarSuccess(message: state.message, context: context);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => PostScreen()),
                    ),
                    (route) => false);
              } else if (state is ErorrAddUpdateDeletPosts) {
                Navigator.pop(context);
                SnackBarWidget()
                    .snackBarErorr(message: state.message, context: context);
              }
            },
            builder: (context, state) {
              if (state is LoadingAddUpdateDeletPostsState) {
                return loadingPostsScreen();
                // Center(
                //     child: Container(
                //         width: 50, height: 50, child: loadingPostsScreen()));
              }
              return DeleteDilog(postId: post.id!);
            },
          );
        });
  }
}
