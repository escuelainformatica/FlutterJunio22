import 'package:flutter/material.dart';
import 'package:untitled8/paginas/home.dart';
import 'package:untitled8/servicios/autenticacion.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController txtUser = TextEditingController();
  TextEditingController txtPwd = TextEditingController();
  bool? recordar=false;
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  bool _passwordVisible = false;

  @override
  void initState() {
    _passwordVisible = false;
    cargaInicial();
  }
  cargaInicial() async {
    final SharedPreferences prefs = await _prefs;
    recordar=prefs.getBool('recordar');
    recordar=recordar==null?false:recordar;
    if(recordar==true) {
      // si el usuario y clave es correcta, navego a la pagina Home.
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(builder: (BuildContext context) => const Home(),),
      );

    }
    print(recordar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(100.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
                controller: txtUser,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your username',
                )),
            TextFormField(
                controller: txtPwd,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your password',
                )),
            Row(
              children: [
                Checkbox(value: recordar, onChanged:(valor) {
                  setState(() {
                    this.recordar = valor;
                  });
                }),
                Text("Recordar ingreso")
              ],
            ),
            SizedBox(height: 40,),
            ElevatedButton(
                onPressed: () async {
                  var resultado = await Autenticacion.login(
                      txtUser.value.text, txtPwd.value.text,recordar);
                  if (resultado == true) {
                    // si el usuario y clave es correcta, navego a la pagina Home.
                    await Navigator.pushReplacement(
                      context,
                      MaterialPageRoute<void>(builder: (BuildContext context) => const Home(),),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        action: SnackBarAction(
                          label: 'Action',
                          onPressed: () {
                            // Code to execute.
                          },
                        ),
                        content: const Text('Awesome SnackBar!'),
                        duration: const Duration(milliseconds: 1500),
                        width: 280.0,
                        // Width of the SnackBar.
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, // Inner padding for SnackBar content.
                        ),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    );
                  }
                },
                child: Text("login"))
          ],
        ),
      ),
    );
  }
}
