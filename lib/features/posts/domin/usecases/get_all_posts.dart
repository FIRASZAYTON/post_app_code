import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/post.dart';
import '../repositories/post_repositories.dart';

class GetAllPostsUsecases {
  final PostsRepository repository;

  GetAllPostsUsecases(this.repository);
  Future<Either<Failure, List<Post>>> call() async {
    return await repository.getAllposts();
  }
}
