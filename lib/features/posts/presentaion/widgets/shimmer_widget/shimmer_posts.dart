import 'package:clean_architecture/core/const/const.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerPosts extends StatelessWidget {
  const ShimmerPosts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KBackGroundColorScaffold,
      body: Shimmer.fromColors(
        baseColor: Colors.grey.withOpacity(0.4),
        highlightColor: Colors.black.withOpacity(0.1),
        child: ListView.separated(
          itemCount: 20,
          itemBuilder: (context, index) => Card(
            elevation: 2,
            shadowColor: Colors.grey.shade400.withOpacity(0.1),
            child: Container(
              width: double.infinity,
              height: 230,
            ),
          ),
          separatorBuilder: (context, index) => Divider(
            thickness: 1,
            color: Colors.grey.withOpacity(0.4),
          ),
        ),
      ),
    );
  }
}
