part of 'products_cubit.dart';

@freezed
class ProductsState with _$ProductsState {
  const factory ProductsState.initial() = _Initial;
  const factory ProductsState.loading() = _Loading;
  const factory ProductsState.success({
    required List<Product> products,
    @Default(false) bool isLoadingMore,
  }) = _Success;
  const factory ProductsState.error({required ErrorResponse errorResponse}) =
      _Error;
}
