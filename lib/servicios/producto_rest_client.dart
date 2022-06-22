import 'package:untitled8/modelo/product.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:untitled8/servicios/autenticacion.dart';

class ProductoRestClient {
  static Future<int> actualizar(Product prod) async {
    var url = Uri.http(
        '158.101.30.194', '/testcli/examples/oraclevm2/api/Product/update', {});
    var productoJson = convert.jsonEncode(prod.toJson());
    var response = await http.post(url,
        body: productoJson, headers: {'token': Autenticacion.tokenBear});
    if (response.statusCode == 200) {
      var responseAsMap = convert.jsonDecode(response.body) as dynamic;
      return int.parse(responseAsMap.toString());
    } else {
      print(response.body);
      print('Request failed with status: ${response.statusCode}.');
      return 0;
    }
  }

  static Stream<List<Product>> leer() async* {
    var url = Uri.http('158.101.30.194',
        '/testcli/examples/oraclevm2/api/Product/listall', {});

// Await the http get response, then decode the json-formatted response.
    var response =
        await http.post(url, headers: {'token': Autenticacion.tokenBear});
    if (response.statusCode == 200) {
      var responseAsMap = convert.jsonDecode(response.body) as List<dynamic>;

      List<Product> resultados =
          responseAsMap.map((e) => Product.fromJson(e)).toList();
      yield resultados;
      print('Number of books about http:');
    } else {
      print(response.body);
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
