import 'package:pxsera/src/models/models.dart';

class searched_photos {
  int? total;
  int? totalPages;
  List<Photo> photos = [];

  searched_photos({this.total, this.totalPages, required this.photos});

  searched_photos.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    totalPages = json['total_pages'];
    photos = (json['results'] as List).map((e) => Photo.fromMap(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['total_pages'] = this.totalPages;
    data['result'] = this.photos;
    return data;
  }
}
