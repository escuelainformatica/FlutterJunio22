import 'package:flutter/material.dart';
import 'package:untitled8/modelo/product.dart';
import 'package:untitled8/servicios/producto_rest_client.dart';

class ProductoEditar extends StatefulWidget {
  Product product;
  ProductoEditar({Key? key,required this.product}) : super(key: key);

  @override
  _ProductoEditarState createState() => _ProductoEditarState();
}

class _ProductoEditarState extends State<ProductoEditar> {
  TextEditingController txtName=TextEditingController();
  TextEditingController txtCat=TextEditingController();
  TextEditingController txtPrice=TextEditingController();

  @override
  Widget build(BuildContext context) {
    txtName.text=widget.product.name??"sin nombre";
    txtCat.text=widget.product.idProductCategory.toString();
    txtPrice.text=widget.product.price??"sin precio";
    return Scaffold(
        appBar: AppBar(
          title: Text("Editar producto"),
        ),
        body: Form(
            child: ListView(
          children: [
            TextFormField(controller: txtName  ),
            TextFormField(controller: txtCat,keyboardType: TextInputType.number),
            TextFormField(controller: txtPrice),
            ElevatedButton(onPressed: () async {
              widget.product.name=txtName.value.text;
              widget.product.idProductCategory=int.parse(txtCat.value.text);
              widget.product.price=txtPrice.value.text;
              int resultado=await ProductoRestClient.actualizar(widget.product);
              if(resultado==1) {
                Navigator.pop(context);
              }
              print(resultado);



            }, child: Text("Editar producto"))
          ],
        )));
  }
}
