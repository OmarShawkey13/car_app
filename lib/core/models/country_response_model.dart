import 'package:car_app/core/models/country_model.dart';
import 'package:car_app/core/models/links_model.dart';
import 'package:car_app/core/models/meta_model.dart';

class CountryResponseModel {
  final List<CountryModel> data;
  final LinksModel links;
  final MetaModel meta;

  CountryResponseModel({
    required this.data,
    required this.links,
    required this.meta,
  });

  factory CountryResponseModel.fromJson(Map<String, dynamic> json) {
    return CountryResponseModel(
      data: (json['data'] as List)
          .map((e) => CountryModel.fromJson(e))
          .toList(),
      links: LinksModel.fromJson(json['links']),
      meta: MetaModel.fromJson(json['meta']),
    );
  }
}
