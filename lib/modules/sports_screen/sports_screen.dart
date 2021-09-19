import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/news_layout/cubit/cubit.dart';
import 'package:news_app/news_layout/cubit/state.dart';
import 'package:news_app/shared/components/components.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).sports;
        return ConditionalBuilder(
          condition: list.length > 0,
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) => buildArticleItem(list[index], context),
            separatorBuilder: (BuildContext context, int index) => myDivider(),
            itemCount: 10, ),
          fallback:(context) => Center(child: CircularProgressIndicator()) ,);
      },
    );
  }
}
