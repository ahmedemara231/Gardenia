import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardenia/modules/data_types/posts_data.dart';
import 'package:gardenia/view_model/home/states.dart';

class HomeCubit extends Cubit<HomeStates>
{
  HomeCubit() : super(HomeInitialState());
  factory HomeCubit.getInstance(context) => BlocProvider.of(context);

  List<PostData> posts =
  [
    PostData(userImageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKXYSs2F_0O04sLv8AjIH43Owr2rEIfkFEOA&usqp=CAU', userName: 'Ahmed Emara', postImage: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKXYSs2F_0O04sLv8AjIH43Owr2rEIfkFEOA&usqp=CAU', postCaption: 'Hello to everyone', commentsNumber: 15),
    PostData(userImageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqQMwq_mZ2I9qpXPhmIeJ5on2jZTavrF65Kw&usqp=CAU', userName: 'abdallah saad', postImage: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqQMwq_mZ2I9qpXPhmIeJ5on2jZTavrF65Kw&usqp=CAU', postCaption: 'Hello Gyes', commentsNumber: 50),
    PostData(userImageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAOk_Z2l6Qsdg6BO3fhHSJZs1O3Wv4QQknng&usqp=CAU', userName: 'Shrouk', postImage: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAOk_Z2l6Qsdg6BO3fhHSJZs1O3Wv4QQknng&usqp=CAU', postCaption: 'Hello everybody', commentsNumber: 20),
    PostData(userImageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-eF2EPE0vA6B9cNIfTX_lnizV3OGwTdADaA&usqp=CAU', userName: 'Rewan Elmallah', postImage: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-eF2EPE0vA6B9cNIfTX_lnizV3OGwTdADaA&usqp=CAU', postCaption: 'Welcome', commentsNumber: 10),
    PostData(userImageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRlCovEjfkoAOO2lBxcLc1X9bakoJryadHWOQ&usqp=CAU', userName: 'Rahaf', postImage: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRlCovEjfkoAOO2lBxcLc1X9bakoJryadHWOQ&usqp=CAU', postCaption: 'Welcome Guyes', commentsNumber: 30),
  ];
  Future<void> getAllPosts()async {}

  List<PostData> favorites = [];
  void addToFavorites(PostData post)
  {
    favorites.add(post);
    print(favorites);
    emit(AddToFavoritesState());
  }

  void removeFromFavorites(PostData post)
  {
    favorites.remove(post);
    print(favorites);
    emit(RemoveFromFavoritesState());
  }
}


