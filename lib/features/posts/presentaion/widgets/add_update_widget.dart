import '../../../../core/const/const.dart';
import '../../domin/entities/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/textField.dart';
import '../bloc/add_update_delet_posts_bloc/add_update_delet_posts_bloc.dart';

class AddUpdateWidget extends StatefulWidget {
  final Post? post;
  final bool isUpdatePost;
  const AddUpdateWidget({Key? key, this.post, required this.isUpdatePost})
      : super(key: key);

  @override
  State<AddUpdateWidget> createState() => _AddUpdateWidgetState();
}

class _AddUpdateWidgetState extends State<AddUpdateWidget> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  @override
  void initState() {
    if (widget.isUpdatePost) {
      titleController.text = widget.post!.title;
      bodyController.text = widget.post!.body;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          TextFieldWidget(
              style: KtitleTheme,
              text: "Title",
              Controller: titleController,
              max: 1,
              min: 1),
          SizedBox(
            height: 40,
          ),
          TextFieldWidget(
              style: KsubTitleTheme,
              Controller: bodyController,
              text: "Body",
              max: 6,
              min: 6),
          SizedBox(
            height: 15,
          ),
          ElevatedButton.icon(
            style: ButtonStyle(
                elevation: MaterialStateProperty.all(2),
                backgroundColor:
                    MaterialStateProperty.all(Colors.black.withOpacity(0.8))),
            onPressed: validateFromThenUpdateOrAddPost,
            icon: Icon(
                widget.isUpdatePost ? Icons.edit : Icons.add_to_photos_rounded,
                color: KiconButton),
            label: Text(widget.isUpdatePost ? "Update " : "Add",
                style: KtitleButton),
          ),
        ]),
      ),
    );
  }

  void validateFromThenUpdateOrAddPost() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      final post = Post(
          id: widget.isUpdatePost ? widget.post!.id : null,
          title: titleController.text,
          body: bodyController.text);

      if (widget.isUpdatePost) {
        // عم ابعت event
        BlocProvider.of<AddUpdateDeletPostsBloc>(context)
            .add(UpdatePostEvent(post));
      } else {
        BlocProvider.of<AddUpdateDeletPostsBloc>(context)
            .add(AddPostEvent(post));
      }
    }
  }
}
