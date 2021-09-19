import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/search_screen/search_screen.dart';
import 'package:news_app/network/remote/dio_helper.dart';
import 'package:news_app/news_layout/app_cubit/app_cubit.dart';
import 'package:news_app/news_layout/cubit/cubit.dart';
import 'package:news_app/news_layout/cubit/state.dart';
import 'package:news_app/shared/components/components.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state){},
      builder: (context, state){
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('News Application'),
            actions: [
              IconButton(icon: Icon(Icons.search), onPressed: (){
                navigateTo(context, SearchScreen(),);
              }),
              IconButton(icon: Icon(Icons.brightness_4_outlined), onPressed: (){
                AppCubit.get(context).toggleDarkMode();
              }),

            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            elevation: 0.0,
            selectedItemColor: Colors.deepOrange,
            items: cubit.bottomNavItem,
            onTap: (index){
              cubit.changeBottomNavBar(index);
            },
          ),
        );
      },
    );
  }
}
