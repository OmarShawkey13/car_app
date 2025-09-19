class LinksModel {
  final String? first;
  final String? last;
  final String? prev;
  final String? next;

  LinksModel({this.first, this.last, this.prev, this.next});

  factory LinksModel.fromJson(Map<String, dynamic> json) {
    return LinksModel(
      first: json['first'],
      last: json['last'],
      prev: json['prev'],
      next: json['next'],
    );
  }
}
