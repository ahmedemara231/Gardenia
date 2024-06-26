abstract class HomeStates{}

class HomeInitialState extends HomeStates{}

class AddToFavoritesState extends HomeStates{}

class RemoveFromFavoritesState extends HomeStates{}

class GetPostsLoadingState extends HomeStates{}

class GetPostsSuccessState extends HomeStates{}

class GetPostsErrorState extends HomeStates{}

class GetPostsNetworkErrorState extends HomeStates{
  String message;
  GetPostsNetworkErrorState({required this.message,});
}

class EditPostLoadingState extends HomeStates{}

class EditPostSuccessState extends HomeStates{}

class EditPostErrorState extends HomeStates{}

class DeletePostSuccess extends HomeStates{}

class DeletePostError extends HomeStates{}

class GetCommentsLoading extends HomeStates{}

class GetCommentsSuccess extends HomeStates{}

class GetCommentsError extends HomeStates{}

class CreateCommentLoading extends HomeStates{}

class CreateCommentSuccess extends HomeStates{}

class CreateCommentError extends HomeStates{}

class DeleteCommentSuccess extends HomeStates{}

class DeleteCommentError extends HomeStates{}
