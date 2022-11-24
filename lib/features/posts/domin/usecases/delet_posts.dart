import '../repositories/post_repositories.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

class DeletPostsUsecase {
  final PostsRepository repository;

  DeletPostsUsecase(this.repository);
  Future<Either<Failure, Unit>> call(int postId) async {
    return await repository.deletPost(postId);
  }
}
