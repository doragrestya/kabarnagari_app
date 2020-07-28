//import 'package:flutter/material.dart';
//
//class EditPage extends StatefulWidget {
//  String title, content, deskripsi, image;
//  EditPage({this.title, this.content, this.deskripsi, this.image});
//  @override
//  _EditPageState createState() => _EditPageState();
//}
//
//class _EditPageState extends State<EditPage> {
//  TextEditingController etTitle = TextEditingController();
//  TextEditingController etContent = TextEditingController();
//  TextEditingController etDescription = TextEditingController();
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: AppBar(
//          centerTitle: true,
//          backgroundColor: Colors.white,
//          title: Text(
//            'Edit a post',
//            style: TextStyle(color: Colors.red),
//          ),
//          actions: <Widget>[
//            FlatButton(
//              onPressed: () async {
//                network.addNews(
//                    etTitle.text.toString(),
//                    etContent.text.toString(),
//                    etDescription.text.toString(),
//                    _image);
//                Navigator.pop(context);
//                await network.getNews("");
//                network.sendNotification(
//                    ConstantFile().imageUrl + path.basename(_image.path));
//              },
//              child: Text('POST'),
//            )
//          ],
//        ),
//        body: ListView(
//          children: <Widget>[
//            Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                TextFormField(
//                  controller: etTitle,
//                  maxLines: 5,
//                  minLines: 2,
//                  decoration: InputDecoration(
//                    contentPadding: EdgeInsets.all(16),
//                    hintText: 'Input Your Title',
//                  ),
//                ),
//                TextFormField(
//                  controller: etContent,
//                  minLines: 2,
//                  maxLines: 5,
//                  decoration: InputDecoration(
//                    contentPadding: EdgeInsets.all(16),
//                    hintText: 'Input Your Context',
//                  ),
//                ),
//                TextFormField(
//                  controller: etDescription,
//                  minLines: 3,
//                  maxLines: 15,
//                  decoration: InputDecoration(
//                      contentPadding: EdgeInsets.all(16),
//                      hintText: "What's on your mind"),
//                ),
//                Padding(
//                  padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
//                  child: _image == null
//                      ? Center()
//                      : ClipRRect(
//                    borderRadius: BorderRadius.circular(8),
//                    child: Image.file(
//                      _image,
//                      fit: BoxFit.fill,
//                      width: MediaQuery.of(context).size.width,
//                      height: MediaQuery.of(context).size.height / 6,
//                    ),
//                  ),
//                ),
//                Padding(
//                  padding: const EdgeInsets.all(16.0),
//                  child: RaisedButton(
//                    shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.circular(8)),
//                    color: Colors.red,
//                    child: Text(
//                      'Select Image',
//                      style: TextStyle(color: Colors.white),
//                    ),
//                    onPressed: () {
//                      myAlert();
//                    },
//                  ),
//                ),
//              ],
//            ),
//          ],
//        ));
//  }
//}
