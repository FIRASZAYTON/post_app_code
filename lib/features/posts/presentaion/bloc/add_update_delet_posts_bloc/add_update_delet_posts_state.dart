part of 'add_update_delet_posts_bloc.dart';

abstract class AddUpdateDeletPostsState extends Equatable {
  const AddUpdateDeletPostsState();

  @override
  List<Object> get props => [];
}

class AddUpdateDeletPostsInitial extends AddUpdateDeletPostsState {}
class LoadingAddUpdateDeletPostsState extends AddUpdateDeletPostsState {}
class ErorrAddUpdateDeletPosts extends AddUpdateDeletPostsState {
  final String message;

  ErorrAddUpdateDeletPosts({required this.message});
  @override
  List<Object> get props => [message];
}



class MessageAddUpdateDeletPosts extends AddUpdateDeletPostsState {
  final String message;

  MessageAddUpdateDeletPosts({required this.message});
  @override
  List<Object> get props => [message];
}
