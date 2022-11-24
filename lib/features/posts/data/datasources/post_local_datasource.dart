import 'dart:convert';

import '../../../../core/error/exception.dart';
import '../models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostlocalDataSource {
  Future<List<PostModel>> getCachedPosts();
  Future<Unit> cachePosts(List<PostModel> postModel);
}

const CACHED_POSTS = "CACHED_POSTS";

class PostImplWithLocalData implements PostlocalDataSource {
  final SharedPreferences sharedPreferences;

  PostImplWithLocalData({required this.sharedPreferences});
  @override
  Future<Unit> cachePosts(List<PostModel> postModel) {
    List postModelsToJson = postModel
        .map<Map<String, dynamic>>((PostModel) => PostModel.toJson())
        .toList();
    sharedPreferences.setString(CACHED_POSTS, json.encode(postModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final jsonString = sharedPreferences.getString(CACHED_POSTS);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<PostModel> jsonToModels = decodeJsonData
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return Future.value(jsonToModels);
    } else {
      throw EmptyCachException();
    }
  }
}
