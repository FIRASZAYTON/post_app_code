import '../../../../core/const/const.dart';
import '../bloc/add_update_delet_posts_bloc/add_update_delet_posts_bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteDilog extends StatelessWidget {
  final int postId;
  const DeleteDilog({Key? key, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 5,
      backgroundColor: KBackGroundColorAppBar,
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      title: Text("Are You Sure ?"),
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 20,
        color: Colors.black87,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "No",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.grey.shade300),
            shadowColor: MaterialStateProperty.all(Colors.amber),
          ),
        ),
        TextButton(
            onPressed: () {
              BlocProvider.of<AddUpdateDeletPostsBloc>(context)
                  .add(DeletePostEvent(postId));
            },
            child: Text(
              "Yes",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            )),
      ],
    );
  }
}
