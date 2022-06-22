import 'package:flutter/material.dart';
import 'package:untitled8/modelo/product.dart';
import 'package:untitled8/paginas/producto_editar.dart';

class ProductoElemento extends StatefulWidget {
  Product product;
  ProductoElemento({Key? key,required this.product}) : super(key: key);

  @override
  _ProductoElementoState createState() => _ProductoElementoState();
}

class _ProductoElementoState extends State<ProductoElemento> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductoEditar(product:widget.product,)),
        );
        setState(() {
          // recargar contenido
        });
      },
      child: Card(
        child: ListTile(
          leading: Text(widget.product.price??"sin precio"),
          title: Text(widget.product.name??"sin nombre"),
        ),
      )
    );
  }
}
