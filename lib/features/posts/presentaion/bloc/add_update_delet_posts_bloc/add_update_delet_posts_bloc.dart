import 'package:bloc/bloc.dart';
import '../../../domin/entities/post.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/strings/failure.dart';
import '../../../../../core/strings/messages.dart';
import '../../../domin/usecases/add_posts.dart';
import '../../../domin/usecases/delet_posts.dart';
import '../../../domin/usecases/update_posts.dart';

part 'add_update_delet_posts_event.dart';
part 'add_update_delet_posts_state.dart';

class AddUpdateDeletPostsBloc
    extends Bloc<AddUpdateDeletPostsEvent, AddUpdateDeletPostsState> {
  final AddPostsUsecase addPostsUsecase;

  final UpdatePostsUsecase updatePostsUsecase;
  final DeletPostsUsecase deletPostsUsecase;

  AddUpdateDeletPostsBloc(
      {required this.addPostsUsecase,
      required this.updatePostsUsecase,
      required this.deletPostsUsecase})
      : super(AddUpdateDeletPostsInitial()) {
    on<AddUpdateDeletPostsEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddUpdateDeletPostsState());
        final failureOrDoneMessage = await addPostsUsecase.call(event.post);
        emit(_ethierDoneMessage(failureOrDoneMessage, ADD_SUCCESS_MESSAGE));
      } else if (event is UpdatePostEvent) {
        emit(LoadingAddUpdateDeletPostsState());
        final failureOrDoneMessage = await updatePostsUsecase.call(event.post);

        emit(_ethierDoneMessage(failureOrDoneMessage, UPDATE_SUSCESS_MESSAGE));
      } else if (event is DeletePostEvent) {
        emit(
          LoadingAddUpdateDeletPostsState(),
        );
        final failureOrDoneMessage = await deletPostsUsecase.call(event.postId);

        emit(_ethierDoneMessage(failureOrDoneMessage, DELETE_SUSCESS_MESSAGE));
      }
    });
  }
  AddUpdateDeletPostsState _ethierDoneMessage(
      Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) => ErorrAddUpdateDeletPosts(
        message: _mapFailureToMessage(failure),
      ),
      (_) => MessageAddUpdateDeletPosts(message: message),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;

      case offlineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Erorr , please try agin later";
    }
  }
}
