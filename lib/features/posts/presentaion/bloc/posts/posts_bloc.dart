import 'package:bloc/bloc.dart';
import '../../../../../core/error/failure.dart';
import '../../../domin/entities/post.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/strings/failure.dart';
import '../../../domin/usecases/get_all_posts.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUsecases getAllPostsUsecases;
  PostsBloc({required this.getAllPostsUsecases}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvents) {
        emit(LoadingPostsState());
        final postsOrFailure = await getAllPostsUsecases.call();
        emit(_mapFailureOrPostsToState(postsOrFailure));
      } else if (event is RefreshPostsEvents) {
        emit(LoadingPostsState());
        final postsOrFailure2 = await getAllPostsUsecases.call();
        emit(_mapFailureOrPostsToState(postsOrFailure2));
      }
    });
  }
  PostsState _mapFailureOrPostsToState(Either<Failure, List<Post>> either) {
    return either.fold(
      (failure) => ErorrPostsState(
        _mapFailureToMessage(failure),
      ),
      (posts) => LoadedPostsState(posts: posts),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;

      case EmptyCacheFailure:
        return EMPY_CACHE_FAILURE_MESSAGE;
      case offlineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Erorr , please try agin later";
    }
  }
}
