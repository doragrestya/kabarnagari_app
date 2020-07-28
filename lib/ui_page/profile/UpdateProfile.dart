import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:flutter_news_app/network/NetworkProvider.dart';
import 'package:flutter_news_app/utils/SessionManager.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfile extends StatefulWidget {
  String id, name, email, photo;
  UpdateProfile({this.name, this.email, this.photo, this.id});

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController etName;
  TextEditingController etEmail;
  File _image;
  SessionManager sessionManager = SessionManager();
  BaseEndPoint network = NetworkProvider();

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future getImage(ImageSource media) async {
    var img = await ImagePicker.pickImage(source: media);
    setState(() {
      _image = img;
    });
  }

  void checkUpdate() {
    if (_image == null) {
      network.updateProfile(
          widget.id, etName.text.toString(), etEmail.text.toString(), "123123");
      sessionManager.savePreference(true, widget.id, etName.text.toString(),
          etEmail.text.toString(), path.basename(_image.path));
    } else {
      network.updateImage(widget.id, _image);
      network.updateProfile(
          widget.id, etName.text.toString(), etEmail.text.toString(), "123123");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      etName = TextEditingController(text: widget.name);
      etEmail = TextEditingController(text: widget.email);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                  child: _image == null
                      ? GestureDetector(
                          onTap: () {
                            myAlert();
                          },
                          child: Container(
                            height: 75,
                            width: 75,
                            child: CircleAvatar(
                              radius: 100,
                            ),
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            _image,
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 5,
                          ),
                        ),
                ),
                TextFormField(
                  controller: etName,
                  decoration: InputDecoration(
                    hintText: 'Your Full Name',
                  ),
                ),
                TextFormField(
                  controller: etEmail,
                  decoration: InputDecoration(
                    hintText: 'Your Email',
                  ),
                ),
                RaisedButton(
                  color: Colors.green,
                  child: Text(
                    'Update Profile',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    checkUpdate();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
