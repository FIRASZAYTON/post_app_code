import '../entities/post.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/post_repositories.dart';

class AddPostsUsecase {
  final PostsRepository repository;

  AddPostsUsecase(this.repository);
  Future<Either<Failure, Unit>> call(Post postId) async {
    return await repository.addPost(postId);
  }
}
