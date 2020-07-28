import 'package:flutter/material.dart';
import 'package:flutter_news_app/constant/ConstantFile.dart';
import 'package:flutter_news_app/model/ModelNews.dart';

class itemListHorizontal extends StatelessWidget {
  List list;
  itemListHorizontal({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        Article data = list[index];
        return Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  ConstantFile().imageUrl + data.imageNews,
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width,
                ),
              ),

              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: EdgeInsets.all(20),
                  width: 100,
                  child: Text(
                    data.categoryNews,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
