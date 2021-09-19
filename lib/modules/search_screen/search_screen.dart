import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/news_layout/cubit/cubit.dart';
import 'package:news_app/news_layout/cubit/state.dart';
import 'package:news_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key key}) : super(key: key);


  @override

  Widget build(BuildContext context)

  {
    var searchController = TextEditingController();
    return BlocConsumer<NewsCubit, NewsStates>(
     listener: (context, state) {},
     builder: (context, state)
     {
       var list = NewsCubit.get(context).search;

       return Scaffold(
         appBar: AppBar(),
         body: Column(
           children: [
             SingleChildScrollView(
               child: Padding(
                 padding: const EdgeInsets.all(20.0),
                 child: defaultFormText(
                     controller: searchController,
                     type: TextInputType.text,
                     prefix: Icons.search,
                     onChange: (value)
                     {
                       NewsCubit.get(context).getSearch(value);
                     },
                     validate: (String value) {
                       if (value.isEmpty)
                       {
                         return 'Search must not be empty';
                       }
                       return null;
                     },
                     label: 'Search'),
               ),
             ),
             Expanded(child: articleBuilder(
                 list,
                 context,
                 isSearch: true,
             )),
           ],
         ),
       );
     },
    );
  }
}
