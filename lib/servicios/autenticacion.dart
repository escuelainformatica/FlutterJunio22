import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled8/modelo/web_token.dart';

class Autenticacion {
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static String usuario='';
  static String level='';
  static String tokenBear='';

  static Future<bool> login(String user,String password,bool? recordar) async {
    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview
    //http://158.101.30.194/testcli/examples/oraclevm2/api/User/createauth

    final SharedPreferences prefs = await _prefs;

    var body={"UserName":user,"Password":password};
    var bodyAsJson=convert.jsonEncode(body);

    var url =
    Uri.http('158.101.30.194', '/testcli/examples/oraclevm2/api/User/createauth', {});

    // Await the http get response, then decode the json-formatted response.
    var response = await http.post(url,body:bodyAsJson,headers: {'token':''});
    if (response.statusCode == 200) {

      var responseAsMap = convert.jsonDecode(response.body) as Map<String, dynamic>;
      WebToken webToken=WebToken.fromJson(responseAsMap);
      String tokenBear=response.headers['token']??'';
      Autenticacion.usuario=webToken.body!.userName??'Sin usuario';
      prefs.setString('usuario',Autenticacion.usuario );
      prefs.setBool('recordar', recordar??false);
      Autenticacion.level=webToken.body!.level??'Sin nivel';
      prefs.setString('level', level);
      Autenticacion.level=tokenBear;
      prefs.setString('tokenBear', tokenBear);
      return true;
    } else {
      print(response.body);
      print('Request failed with status: ${response.statusCode}.');
    }
    return false;
  }
}