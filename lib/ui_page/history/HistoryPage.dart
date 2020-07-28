import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/constant/ConstantFile.dart';
import 'package:flutter_news_app/model/ModelNews.dart';
import 'package:flutter_news_app/network/NetworkProvider.dart';
import 'package:flutter_news_app/ui_page/home/PageDetail.dart';
import 'package:flutter_news_app/utils/SessionManager.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatefulWidget {

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  String myId;
  BaseEndPoint network = NetworkProvider();
  SessionManager sessionManager = SessionManager();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      sessionManager.getPreference().then((value){
        setState(() {
          myId = sessionManager.globIduser;
          print(myId);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        FutureBuilder(
          future: network.getNews(myId),
          builder:
              (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.hasError) print(snapshot.error);
            return snapshot.hasData ?
            ItemListVertical(list: snapshot.data)
                : Center(child: CircularProgressIndicator(),);
          },
        ),
      ],
    );
  }
}

class ItemListVertical extends StatefulWidget {
  List list;
  ItemListVertical({this.list});
  @override
  _ItemListVerticalState createState() => _ItemListVerticalState();
}

class _ItemListVerticalState extends State<ItemListVertical> {
//  var tgl = new DateTime.now();
  BaseEndPoint network = NetworkProvider();
  var dateFormat;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: widget.list.length,
      itemBuilder: (BuildContext context, int index) {
        Article data = widget.list[index];
        dateFormat = DateFormat("dd-MM-yyyy").format(data.dateNews);
        return   Padding(
          padding: const EdgeInsets.only(left: 3, right: 3, bottom: 8),
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
                                        builder: (context) =>
                                            PageDetail(
                                                title : data.titleNews,
                                                content : data.contentNews,
                                                deskripsi : data.descriptionNews,
                                                image : data.imageNews
                                            )));
                              },
                              child: Text(
                                data.titleNews,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        "| Indonesia",
                                        style: TextStyle(color: Colors.red),
                                      )
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
                                ]
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 8,),
              Divider(
                color: Colors.red,
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