import 'package:flutter/material.dart';
import 'package:untitled8/modelo/product.dart';
import 'package:untitled8/servicios/producto_rest_client.dart';

class ProductoEditar extends StatefulWidget {
  Product product;

  ProductoEditar({Key? key, required this.product}) : super(key: key);

  @override
  _ProductoEditarState createState() => _ProductoEditarState();
}

class _ProductoEditarState extends State<ProductoEditar> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtCat = TextEditingController();
  TextEditingController txtPrice = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  @override
  Widget build(BuildContext context) {
    txtName.text = widget.product.name ?? "sin nombre";
    txtCat.text = widget.product.idProductCategory.toString();
    txtPrice.text = widget.product.price ?? "sin precio";
    return Scaffold(
        appBar: AppBar(
          title: Text("Editar producto"),
        ),
        body: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  validator: (valor) {
                    if(valor==null || valor=="") {
                      return "Debe ingresar un valor";
                    }
                    if(valor.length>40) {
                      return "El largo debe ser menos de 40 caracteres";
                    }
                    return null; // no hay error
                  } ,
                  controller: txtName,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Nombre',
                  ),
                ),
                TextFormField(
                  validator: (valor) {
                    return isNumeric(valor)?null:"el valor debe ser numerico";
                    } ,
                  controller: txtCat,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Numero de categoria',
                  ),
                ),
                TextFormField(
                  validator: (valor) {
                    return isNumeric(valor)?null:"el valor debe ser numerico";
                  } ,
                  controller: txtPrice,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Precio',
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        widget.product.name = txtName.value.text;
                        widget.product.idProductCategory =
                            int.parse(txtCat.value.text);
                        widget.product.price = txtPrice.value.text;
                        int resultado =
                            await ProductoRestClient.actualizar(widget.product);
                        if (resultado == 1) {
                          Navigator.pop(context);
                        }
                        print(resultado);
                      }
                    },
                    child: Text("Editar producto"))
              ],
            )));
  }
}
