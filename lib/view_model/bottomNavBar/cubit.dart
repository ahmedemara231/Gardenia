import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardenia/view_model/bottomNavBar/states.dart';

class BottomNavCubit extends Cubit<BottomNavStates>
{
  BottomNavCubit() : super(BottomNavInitialState());

  factory BottomNavCubit.getInstance(context) => BlocProvider.of(context);

  int currentIndex = 1;
  void changeScreen(int newScreen)
  {
    currentIndex = newScreen;
    emit(ChangeScreenState());
  }
}