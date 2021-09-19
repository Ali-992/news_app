import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/network/remote/dio_helper.dart';
import 'package:news_app/news_layout/app_cubit/app_cubit.dart';
import 'package:news_app/news_layout/cubit/cubit.dart';
import 'package:news_app/news_layout/cubit/news_layout.dart';
import 'package:news_app/styles/bloc_observer.dart';

import 'network/local/cache_helper.dart';
import 'news_layout/app_cubit/app_states.dart';

void main() async {

  //Ensure everything is done before initializing the Application
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool isDark = CacheHelper.getBoolean(key: 'isDark');

  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final bool isDark;

  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => NewsCubit()..getBusinessData(),),
        BlocProvider(create: (BuildContext context) => AppCubit()..toggleDarkMode(
    fromShared: isDark,
    ),)
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {} ,
        builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                  titleSpacing: 20.0,
                  backwardsCompatibility: false, //To control the status bar
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarIconBrightness: Brightness.dark,
                    statusBarColor: Colors.white,
                  ), //StatusBarEditing
                  actionsIconTheme: IconThemeData(
                    color: Colors.black,
                  ),
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,

                  )
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                elevation: 20.0,
                selectedItemColor: Colors.deepOrange,
                selectedIconTheme: IconThemeData(
                  size: 50.0,
                ),
                type: BottomNavigationBarType.fixed,
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            darkTheme:ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: HexColor('#525252'),
              appBarTheme: AppBarTheme(
                  backwardsCompatibility: false, //To control the status bar
                  backgroundColor: HexColor('#525252'),
                  titleSpacing: 20.0,
                  elevation: 0.0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarIconBrightness: Brightness.light,
                    statusBarColor: HexColor('#525252'),
                  ), //StatusBarEditing
                  actionsIconTheme: IconThemeData(
                    color: Colors.white,
                  ),
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,

                  )
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: HexColor('#525252'),
                elevation: 20.0,
                selectedItemColor: Colors.deepOrange,
                selectedIconTheme: IconThemeData(
                  size: 50.0,
                ),
                type: BottomNavigationBarType.fixed,
                unselectedItemColor: Colors.grey,
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

            ),
            debugShowCheckedModeBanner: false,
            home: NewsLayout(),
          );
        },
      ),
    );
  }
}
