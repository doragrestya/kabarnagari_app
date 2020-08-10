import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/constant/ConstantFile.dart';
import 'package:flutter_news_app/model/ModelNews.dart';
import 'package:flutter_news_app/network/NetworkProvider.dart';
import 'package:flutter_news_app/ui_page/home/PageDetail.dart';
import 'package:flutter_news_app/ui_page/home/itemListHorizontal.dart';
import 'package:intl/intl.dart';

class PendidikanPage extends StatefulWidget {
  @override
  _PendidikanPageState createState() => _PendidikanPageState();
}

class _PendidikanPageState extends State<PendidikanPage> {
  BaseEndPoint network = NetworkProvider();
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 16),
          child: Text(
            'Stories',
            style: TextStyle(
                color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
            height: MediaQuery.of(context).size.height / 4,
            child: FutureBuilder(
              future: network.getNews(""),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) print(snapshot.error);
                return snapshot.hasData
                    ? itemListHorizontal(list: snapshot.data)
                    : Center(
                  child: CircularProgressIndicator(),
                );
              },
            )),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 16),
          child: Text(
            'Headlines',
            style: TextStyle(
                color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        FutureBuilder(
          future: network.getPendidikan(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? itemListPendidikan(
              list: snapshot.data,
            )
                : Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ],
    );
  }
}

class ListPendidikan extends StatefulWidget {
  List list;
  ListPendidikan({this.list});
  @override
  _ListPendidikanState createState() => _ListPendidikanState();
}

class _ListPendidikanState extends State<ListPendidikan> {
  BaseEndPoint network = NetworkProvider();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 16),
          child: Text(
            'Headlines',
            style: TextStyle(
                color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        FutureBuilder(
          future: network.getPendidikan(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? itemListPendidikan(
              list: snapshot.data,
            )
                : Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ],
    );
  }
}

class itemListPendidikan extends StatefulWidget {
  List list;
  itemListPendidikan({this.list});
  @override
  _itemListPendidikanState createState() => _itemListPendidikanState();
}

class _itemListPendidikanState extends State<itemListPendidikan> {
  BaseEndPoint network = NetworkProvider();
  var dateFormat;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: widget.list.length,
      itemBuilder: (BuildContext context, int index) {
        final data = widget.list[index];
        dateFormat = DateFormat("dd-MM-yyyy").format(data.dateNews);
        return Padding(
          padding: const EdgeInsets.only(left: 16, right: 2, bottom: 8),
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 120,
                      width: 120,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            ConstantFile().imageUrl + data.imageNews,
                            fit: BoxFit.fill,
                          )),
                    ),
                    Flexible(
                      flex: 6,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PageDetail(
                                          title: data.titleNews,
                                          content: data.contentNews,
                                          deskripsi: data.descriptionNews,
                                          image: data.imageNews,
                                        )));
                              },
                              child: Text(
                                data.titleNews,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                                maxLines: 2,
                              ),
                            ),
                            Text(
                              data.contentNews,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                              softWrap: true,
                              maxLines: 3,
                            ),
                            Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Icon(Icons.access_time),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(dateFormat),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        '| Olahraga',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                      icon: Icon(Icons.delete_forever,
                                          color: Colors.red),
                                      onPressed: () {
                                        AwesomeDialog(
                                            context: context,
                                            dialogType: DialogType.ERROR,
                                            animType: AnimType.BOTTOMSLIDE,
                                            tittle: 'Warning',
                                            desc:
                                            'Do You Want to delete this item',
                                            btnCancelOnPress: () {},
                                            btnOkOnPress: () async {
                                              network.deleteNews(data.idNews);
                                              setState(() {
                                                widget.list.removeAt(index);
                                              });
                                              await network.getNews("");
                                            }).show();
                                      }),
                                ]),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Divider(
                color: Colors.pink,
                height: 1,
                thickness: 2,
              ),
            ],
          ),
        );
      },
    );
  }
}

