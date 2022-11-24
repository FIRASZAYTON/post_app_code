import 'package:clean_architecture/core/const/const.dart';
import 'package:flutter/material.dart';

class loadingPostsScreen extends StatelessWidget {
  const loadingPostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Scaffold(
        backgroundColor: KBackGroundColorScaffold,
        body: Padding(
            padding: EdgeInsets.all(30),
            child: Center(
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(color: KBackGroundColorAppBar),
              ),
            )),
      ),
    );
  }
}
