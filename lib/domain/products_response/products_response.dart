import 'package:freezed_annotation/freezed_annotation.dart';

part 'products_response.freezed.dart';
part 'products_response.g.dart';

@freezed
class ProductsResponse with _$ProductsResponse {
  const factory ProductsResponse({
    required List<Product> products,
    required int total,
    required int skip,
    required int limit,
  }) = _ProductsResponse;

  factory ProductsResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductsResponseFromJson(json);
}

@freezed
class Product with _$Product {
  const factory Product({
    required String thumbnail,
    required String title,
    required double price,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}