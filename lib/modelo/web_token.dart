import 'user.dart';

class WebToken {
  User? body;
  String? token;

  WebToken({this.body, this.token});

  WebToken.fromJson(Map<String, dynamic> json) {
    body = json['body'] != null ? User.fromJson(json['body']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.body != null) {
      data['body'] = this.body!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}