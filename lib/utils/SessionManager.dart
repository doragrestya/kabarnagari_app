import 'package:shared_preferences/shared_preferences.dart';

abstract class RuleUtils {
  void savePreference(bool status, String idUser, String fullnameUser,
      String emailUser, String photoUser);
  Future getPreference();
}

class SessionManager extends RuleUtils {
  var globIduser, globName, globEmail, globPhoto; //untuk inputan
  var globStatus; //untuk pembacaan

  @override
  void savePreference(bool status, String idUser, String fullnameUser,
      String emailUser, String photoUser) async {
    // TODO: implement savePreference
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
}
