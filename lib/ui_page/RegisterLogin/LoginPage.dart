import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/model/ModelUser.dart';
import 'package:flutter_news_app/network/NetworkProvider.dart';
import 'package:flutter_news_app/ui_page/DashboardPage.dart';
import 'package:flutter_news_app/ui_page/RegisterLogin/RegisterPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

enum LoginStatus {
  notLogin,
  Login
} //karena sebuah variabel agar terbaca sebagai sebuah variabel (UNTUK SWITCH CASE)

class _LoginPageState extends State<LoginPage> {
  BaseEndPoint network = NetworkProvider();
  TextEditingController etEmail = TextEditingController();
  TextEditingController etPassword = TextEditingController();
  LoginStatus _loginStatus =
      LoginStatus.notLogin; //UNTUK PENGECEKAN DI SWITCH CASE
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  var status = false;
  var globIduser, globName, globEmail, globPhoto; //untuk inputan
  var globStatus; //untuk pembacaan
  var _obSecure = true;
  var _token;
  void onHidePassword() {
    if (_obSecure == true) {
      setState(() {
        _obSecure = false;
      });
    } else {
      setState(() {
        _obSecure = true;
      });
    }
  }

  void onValidate() async {
    if (etEmail.text.isEmpty || etPassword.text.isEmpty) {
      print('Gagal');
    } else {
      List listData = await network.loginUser(
          etEmail.text.toString(),
          etPassword.text.toString(), context);
      User data = listData[0];
      print("myData : ${data.idUser} ${data.fullnameUser} ${data.emailUser} ");
      setState(() {
        status = true;
//      JIKA MENGGUNAKAN NOTIF SEND BROADCAST
//        _firebaseMessaging.getToken().then((token){
//          print('MyToken $token');
//          _token = token;
//        });
        savePreference(status, data.idUser, data.fullnameUser, data.emailUser,
            data.photoUser);
      });
//    sendToDatabase();
    }
  }

  void savePreference(bool status, String idUser, String fullnameUser,
      String emailUser, String photoUser) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("myStatus", status);
    sharedPreferences.setString("myIduser", idUser);
    sharedPreferences.setString("myName", fullnameUser);
    sharedPreferences.setString("myEmail", emailUser);
    sharedPreferences.setString("myPhoto", photoUser);
    sharedPreferences.commit();
  }

  Future getPreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    globStatus = sharedPreferences.getBool("myStatus");
    globIduser = sharedPreferences.get("myIduser");
    globName = sharedPreferences.getString("myName");
    globEmail = sharedPreferences.getString("myEmail");
    globPhoto = sharedPreferences.getString("myPhoto");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPreference();
  }

//  sendToDatabase() async{
//    List listData = await network.loginUser(
//        etEmail.text.toString(), etPassword.text.toString());
//    User data = listData[0];
//    print("myData : ${data.fullnameUser} ${data.emailUser} ${data.idUser}");
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      body: Center(
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(33),
              padding:
                  EdgeInsets.only(top: 32, left: 16, right: 16, bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Login',
                    style: TextStyle(color: Colors.black, fontSize: 24),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Welcome back \nplease Login to \nYour Account',
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    controller: etEmail,
                    decoration: InputDecoration(hintText: 'Email Address',
                   ),
                  ),
                  TextFormField(
                    controller: etPassword,
                    obscureText: _obSecure,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obSecure ? Icons.visibility : Icons.visibility_off,
                            size: 25,
                          ),
                          onPressed: () {
                            onHidePassword();
                          },
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16, bottom: 16),
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: RaisedButton(
                      color: Colors.pink,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      onPressed: () {
                        onValidate();
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white, letterSpacing: 3),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()));
                      },
                      child: Text(
                        'Already have an Account? Sign Up',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
