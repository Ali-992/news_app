import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/network/local/cache_helper.dart';
import 'package:news_app/news_layout/app_cubit/app_states.dart';

class AppCubit extends Cubit<AppStates> {

  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  void toggleDarkMode({bool fromShared}) {
    if(fromShared != null) {
      isDark = fromShared;
    emit(ToggleDarkModeButton());
  } else {
  isDark = !isDark;
  CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
  emit(ToggleDarkModeButton());
  });

  }


  }
}