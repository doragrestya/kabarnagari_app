import 'package:flutter/material.dart';
import 'package:flutter_news_app/constant/ConstantFile.dart';
import 'package:flutter_news_app/model/ModelNews.dart';
import 'package:flutter_news_app/network/NetworkProvider.dart';

class PageDetail extends StatefulWidget {
  String title;
  String content;
  String deskripsi;
  String image;
  PageDetail({this.title, this.content, this.deskripsi, this.image});

  @override
  _PageDetailState createState() => _PageDetailState();
}

class _PageDetailState extends State<PageDetail> {
  BaseEndPoint network = NetworkProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''), backgroundColor: Colors.red, iconTheme: IconThemeData(color: Colors.red),
      ),

      body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text(
                    widget.title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      child: Image.network(ConstantFile().imageUrl + widget.image,
                        fit: BoxFit.fill,),
                    ),
                  ),
                  Card(
                    child: Column(
                      children: <Widget>[
                        Text(
                          widget.content, style: TextStyle(fontSize: 10),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Text(
                            widget.deskripsi, style: TextStyle(fontSize: 15), textAlign: TextAlign.justify,
                          ),
                        ),
                      ],

                    ),
                  )
                ],
              ),
            )
          ],
        ),
    );
  }
}
