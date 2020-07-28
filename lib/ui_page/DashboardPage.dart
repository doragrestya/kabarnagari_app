import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/network/NetworkProvider.dart';
import 'package:flutter_news_app/ui_page/RegisterLogin/LoginPage.dart';
import 'package:flutter_news_app/ui_page/history/HistoryPage.dart';
import 'package:flutter_news_app/ui_page/home/PageHome.dart';
import 'package:flutter_news_app/ui_page/olahraga/OlaharagaPage.dart';
import 'package:flutter_news_app/ui_page/pages/AddPage.dart';
import 'package:flutter_news_app/ui_page/pendidikan/PendidikanPage.dart';
import 'package:flutter_news_app/ui_page/popular/PopularPage.dart';
import 'package:flutter_news_app/ui_page/profile/ProfilePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class DashboardPage extends StatefulWidget {
  final drawerItem = [
    new DrawerItem("Politic", Icons.business_center),
    new DrawerItem("Pendidikan", Icons.book),
    new DrawerItem("Olahraga", Icons.directions_bike),
  ];
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  onSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  var listPage = [PageHome(), PendidikanPage(), ProfilePage(), OlahragaPage()];

  final _bottomNavItem = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.dashboard),
      title: Text('Home'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.book),
      title: Text('Pendidikan'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      title: Text('Profile'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.directions_bike),
      title: Text('Olahraga'),
    ),
  ];

  void signOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    sharedPreferences.commit();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
        (Route<dynamic> route) => false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseMessaging.subscribeToTopic('InternshipTopic');
    _firebaseMessaging.configure(

        //ketika aplikasi masih terbuka
        onMessage: (Map<String, dynamic> message) async {
      print("onMessage: $message");
      final notification = message['notification'];
      final data = message['data'];
      print("Onteset : ${notification['title']}");
      print("Onteset : ${data['image']}");
    },

        //ketika aplikasi tertutup
        onLaunch: (Map<String, dynamic> message) async {
      print("onLaunch: $message");
      final notification = message['notification'];
      print(notification['title']);
    },

        //ketika aplikasi berjalan di latar belakang(background)
        onResume: (Map<String, dynamic> message) async {
      print("onResume: $message");
      final notification = message['notification'];
      print(notification['title']);
    });
  }

  BaseEndPoint network = NetworkProvider();

  int _selectedDrawerIndex = 0;

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItem.length; i++) {
      var d = widget.drawerItem[i];
      drawerOptions.add(new ListTile(
        leading: new Icon(d.icon),
        title: new Text(d.title),
        trailing: new Icon(Icons.arrow_right),
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectItem(i),
      ));
    }

    return Scaffold(
      drawer: Drawer(
        child: new Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: Text("Dora Grestya"),
              accountEmail: Text("doragrestyaa@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor:
                    Theme.of(context).platform == TargetPlatform.iOS
                        ? Colors.pink
                        : Colors.white,
                child: Text(
                  "DG",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
              otherAccountsPictures: <Widget>[
                CircleAvatar(
                  backgroundColor:
                      Theme.of(context).platform == TargetPlatform.iOS
                          ? Colors.pink
                          : Colors.white,
                  child: IconButton(
                      icon: Icon(
                    Icons.exit_to_app,
                    size: 25,
                    color: Colors.red,
                  ),
                  onPressed: (){
                        signOut();
                  },),
                ),
              ],
            ),
            new Column(children: drawerOptions)
          ],
        ),
      ),
      appBar: AppBar(
        actions: <Widget>[
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddPage()));
            },
            child: IconButton(
              icon: Icon(Icons.note_add, color: Colors.white, size: 30,),
            ),
          )
        ],
        centerTitle: true,
        title: Column(
          children: <Widget>[
            SizedBox(
              width: 160,
              height: 30,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Text(
                  "KABAR NAGARI",
                  style: TextStyle(color: Colors.pinkAccent),
                ),
                color: Colors.white,
                onPressed: () {},
              ),
            ),
            Text(
              "The News Application",
              style: TextStyle(fontSize: 10, color: Colors.white),
            )
          ],
        ),),
      body: Center(
        child: listPage[_selectedIndex],
      ),
//      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//      floatingActionButton: FloatingActionButton(
//        backgroundColor: Colors.red,
////        Color(0xFF512DA8),
//        onPressed: () {
//          Navigator.push(
//              context, MaterialPageRoute(builder: (context) => AddPage()));
//        },
//        tooltip: 'Increment',
//        child: Icon(
//          Icons.add,
//          color: Colors.white,
//        ),
//        elevation: 2.0,
//      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.red,
        items: _bottomNavItem,
        currentIndex: _selectedIndex,
        onTap: onSelected,
      ),
    );
  }
}
