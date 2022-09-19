import 'package:pxsera/src/models/models.dart';

class searched_users {
  int? total;
  int? totalPages;
  List<User> users = [];

  searched_users({this.total, this.totalPages, required this.users});

  searched_users.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    totalPages = json['total_pages'];
    users = (json['results'] as List).map((e) => User.fromMap(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['total_pages'] = this.totalPages;
    data['result'] = this.users;
    return data;
  }
}
