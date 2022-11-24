part of 'add_update_delet_posts_bloc.dart';

abstract class AddUpdateDeletPostsEvent extends Equatable {
  const AddUpdateDeletPostsEvent();

  @override
  List<Object> get props => [];
}

class AddPostEvent extends AddUpdateDeletPostsEvent {
  final Post post;

  AddPostEvent(this.post);
  @override
  List<Object> get props => [post];
}

class UpdatePostEvent extends AddUpdateDeletPostsEvent {
  final Post post;

  UpdatePostEvent(this.post);
  @override
  List<Object> get props => [post];
}

class DeletePostEvent extends AddUpdateDeletPostsEvent {
  final int postId;

  DeletePostEvent(this.postId);
  @override
  List<Object> get props => [postId];
}
