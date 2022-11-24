import '../../../../core/error/exception.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/post_remote_datasource.dart';
import '../models/post_model.dart';
import 'package:dartz/dartz.dart';

import '../../domin/entities/post.dart';

import '../../../../core/error/failure.dart';

import '../../domin/repositories/post_repositories.dart';
import '../datasources/post_local_datasource.dart';

typedef Future<Unit> DeletOrUpdateOrAdd();

class PostsRepositoriesImpl implements PostsRepository {
  final NetworkInfo networkInfo;
  final PostlocalDataSource postlocalDataSource;
  final PostRemoteDataSource postRemoteDataSource;

  PostsRepositoriesImpl(
      {required this.networkInfo,
      required this.postlocalDataSource,
      required this.postRemoteDataSource});
  @override
  Future<Either<Failure, List<Post>>> getAllposts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePost = await postRemoteDataSource.getAllposts();
        postlocalDataSource.cachePosts(remotePost);
        return Right(remotePost);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPost = await postlocalDataSource.getCachedPosts();
        return Right(localPost);
      } on EmptyCachException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    // هون ما بهمني ال id 
    PostModel postModel = PostModel(title: post.title, body: post.body);
    return await _getMessage(() {
      return postRemoteDataSource.addPost(postModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deletPost(int postId) async {
    return await _getMessage(() {
      return postRemoteDataSource.deletPost(postId);
    });
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    return await _getMessage(() {
      return postRemoteDataSource.updatetPost(postModel);
    });
  }

  Future<Either<Failure, Unit>> _getMessage(
      DeletOrUpdateOrAdd deletAndUpdateAndAdd) async {
    if (await networkInfo.isConnected) {
      try {
        deletAndUpdateAndAdd;
        return right(unit);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return left(offlineFailure());
    }
  }
}
