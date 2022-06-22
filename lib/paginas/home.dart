import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled8/servicios/autenticacion.dart';
import 'package:untitled8/servicios/producto_rest_client.dart';
import 'package:untitled8/widgets/producto_elemento.dart';

import '../modelo/product.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home"),),
      body: StreamBuilder(
        stream: ProductoRestClient.leer(),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.done) {
            List<Product> datos= snapshot.data as List<Product>;
            return ListView.builder(

                itemCount: datos.length,
                itemBuilder:(context,fila) {
                  return ProductoElemento(product: datos[fila]);
                }
            );
          } else {
            return Text("no data");
          }
        },
      ),
    );
  }
}
