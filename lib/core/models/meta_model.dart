class MetaModel {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  MetaModel({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      perPage: json['per_page'],
      total: json['total'],
    );
  }
}
