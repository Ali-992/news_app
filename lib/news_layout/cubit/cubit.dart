import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business_screen/business_screen.dart';
import 'package:news_app/modules/science_screen/science_screen.dart';
import 'package:news_app/modules/sports_screen/sports_screen.dart';
import 'package:news_app/network/remote/dio_helper.dart';
import 'package:news_app/news_layout/cubit/state.dart';

class NewsCubit extends Cubit<NewsStates> {

  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomNavItem =
  [
  BottomNavigationBarItem(icon: Icon(Icons.business,), label: 'Business'),
  BottomNavigationBarItem(icon: Icon(Icons.sports,), label: 'Sports'),
  BottomNavigationBarItem(icon: Icon(Icons.science,), label: 'Science'),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void changeBottomNavBar(index){
    currentIndex = index;
    if (currentIndex == 1)
      getSportsData();
      emit(NewsGetSportsLoadingState());
    if(currentIndex == 2)
      getScienceData();
      emit(NewsGetScienceLoadingState());

    emit(ChangeNavBottomBarState());
  }



  List<dynamic> business = [];

  void getBusinessData(){
    emit(NewsGetBusinessLoadingState());

    DioHelper.getData(
        url: 'v2/top-headlines',
        query:
    {
      'country':'eg',
      'category':'business',
      'apiKey':'680e742ad84d4608a851b6a050668228',
    }).then((value) {
      business = value.data['articles'];
      emit(NewsGetBusinessDataSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessDataErrorState(error));
    });
  }

  List<dynamic> sports = [];

  void getSportsData(){
    emit(NewsGetSportsLoadingState());

    DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'country':'eg',
          'category':'sports',
          'apiKey':'680e742ad84d4608a851b6a050668228',
        }).then((value) {
      sports = value.data['articles'];
      emit(NewsGetSportsDataSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSportsDataErrorState(error));
    });
  }

  List<dynamic> science = [];

  void getScienceData(){
    emit(NewsGetScienceLoadingState());

    DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'country':'eg',
          'category':'science',
          'apiKey':'680e742ad84d4608a851b6a050668228',
        }).then((value) {
      science = value.data['articles'];
      emit(NewsGetScienceDataSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetScienceDataErrorState(error));
    });
  }

  List<dynamic> search = [];

  void getSearch(String value)
  {
    emit(NewsGetSearchLoadingState());

    search = [];

    DioHelper.getData(
        url: 'v2/everything',
        query:
        {
          'q':'$value',
          'apiKey':'680e742ad84d4608a851b6a050668228',
        }).then((value) {
      search = value.data['articles'];
      emit(NewsGetSearchDataSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSearchDataErrorState(error));
    });
  }
}