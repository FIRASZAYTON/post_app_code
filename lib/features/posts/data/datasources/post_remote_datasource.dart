import 'dart:convert';
import '../../../../core/error/exception.dart';
import '../models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllposts();
  Future<Unit> deletPost(int postId);
  Future<Unit> updatetPost(PostModel postModel);
  Future<Unit> addPost(PostModel postModel);
}

const BaseUrl = "https://jsonplaceholder.typicode.com";

class PostImplWithHttp implements PostRemoteDataSource {
  final http.Client client;

  PostImplWithHttp({required this.client});
  @override
  Future<List<PostModel>> getAllposts() async {
    final response = await client.get(Uri.parse(BaseUrl + "/posts/"),
        headers: {"Content_Type": "application/json"});
    if (response.statusCode == 200) {
      final List decodeJson = json.decode(response.body) as List;
      final List<PostModel> postModels = decodeJson
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();

      return postModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final body = {
      "title": postModel.title,
      "body": postModel.body,
    };
    final response =
        await client.post(Uri.parse(BaseUrl + "/posts/"), body: body);
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletPost(int postId) async {
    final response = await client.delete(
        Uri.parse(BaseUrl + "/posts/${postId.toString()}"),
        headers: {"Content_Type": "application/json"});
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatetPost(PostModel postModel) async {
    final postId = postModel.id.toString();
    final body = {
      "title": postModel.title,
      "body": postModel.body,
    };
    final response =
        await client.patch(Uri.parse(BaseUrl + "/posts/$postId"), body: body);
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
