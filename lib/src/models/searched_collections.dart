import 'package:pxsera/src/models/models.dart';

class searched_collections {
  int? total;
  int? totalPages;
  List<Collection> collections = [];

  searched_collections({this.total, this.totalPages, required this.collections});

  searched_collections.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    totalPages = json['total_pages'];
    collections = (json['results'] as List).map((e) => Collection.fromMap(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['total_pages'] = this.totalPages;
    data['result'] = this.collections;
    return data;
  }
}
