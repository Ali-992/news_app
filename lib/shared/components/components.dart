import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view/web_view_screen.dart';

Widget buildArticleItem(article, context) => InkWell(
  onTap: (){
    navigateTo(
        context,
        WebViewScreen(article['url']), );
  },
  child:   Padding(

        padding: const EdgeInsets.all(20.0),

        child: Row(

          children: [

            Container(

              width: 120.0,

              height: 120.0,

              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(10.0),

                image: DecorationImage(

                  image: NetworkImage(

                      '${article['urlToImage']}'),

                  fit: BoxFit.cover,

                ),

              ),

            ),

            SizedBox(

              width: 20,

            ),

            Expanded(

              child: Container(

                height: 120.0,

                child: Column(

                  mainAxisAlignment: MainAxisAlignment.start,

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Expanded(

                      child: Text(

                        '${article['title']}',

                        maxLines: 3,

                        overflow: TextOverflow.ellipsis,

                        style: Theme.of(context).textTheme.bodyText1,

                      ),

                    ),

                    Text(

                      '${article['publishedAt']}',

                      style: TextStyle(

                        color: Colors.grey,

                      ),

                    ),

                  ],

                ),

              ),

            ),

          ],

        ),

      ),
);

Widget articleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
  condition: list.length > 0,
  builder: (context) => ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) =>
          buildArticleItem(list[index], context),
      separatorBuilder: (context, index) => myDivider(),
      itemCount: 15),
  fallback: (context) =>
  isSearch ? Container() : Center(child: CircularProgressIndicator()),
);

Widget myDivider() => Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.blueGrey,
    );

Widget defaultFormText({
  @required TextEditingController controller,
  @required TextInputType type,
  @required IconData prefix,
  IconData suffix,
  Function onSubmit,
  Function onChange,
  @required Function validate,
  @required String label,
  Function onTap,
  String helper,
  bool isPassword = false,
  Function suffixOnPressed,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      obscureText: isPassword,
      validator: validate,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        helperText: helper,
        border: OutlineInputBorder(),
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: suffixOnPressed,
          icon: Icon(
            suffix,
          ),
        )
            : null,
      ),
    );

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);
