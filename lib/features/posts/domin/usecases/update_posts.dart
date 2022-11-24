import '../entities/post.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/post_repositories.dart';

class UpdatePostsUsecase {
  final PostsRepository repository;

  UpdatePostsUsecase(this.repository);
  Future<Either<Failure, Unit>> call(Post postId) async {
    return await repository.updatePost(postId);
  }
}
