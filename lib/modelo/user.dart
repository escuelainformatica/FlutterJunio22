/** https://javiercbk.github.io/json_to_dart/ */
class User {
  String? userName;
  String? level;

  User({this.userName, this.level});

  User.fromJson(Map<String, dynamic> json) {
    userName = json['UserName'];
    level = json['Level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserName'] = this.userName;
    data['Level'] = this.level;
    return data;
  }
}