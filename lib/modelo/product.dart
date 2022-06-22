class Product {
  int? idProduct;
  String? name;
  int? idProductCategory;
  String? price;

  Product({this.idProduct, this.name, this.idProductCategory, this.price});

  Product.fromJson(Map<String, dynamic> json) {
    idProduct = json['IdProduct'];
    name = json['Name'];
    idProductCategory = json['IdProductCategory'];
    price = json['Price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IdProduct'] = this.idProduct;
    data['Name'] = this.name;
    data['IdProductCategory'] = this.idProductCategory;
    data['Price'] = this.price;
    return data;
  }
}