import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:taghyeer_task/data/api_service/user_api_service.dart';
import 'package:taghyeer_task/domain/error_response/error_response.dart';
import 'package:taghyeer_task/domain/products_response/products_response.dart';

part 'products_state.dart';
part 'products_cubit.freezed.dart';

@injectable
class ProductsCubit extends Cubit<ProductsState> {
  final UserApiService _userService;
  ProductsCubit(this._userService) : super(ProductsState.initial());

  // Products Pagination
  int skip = 0;
  int limit = 10;
  bool isLoading = false;
  bool hasMore = true;
  List<Product> products = [];

  Future<void> getAllProducts() async {
    if (isLoading || !hasMore) return;

    isLoading = true;
    if (products.isEmpty) {
      emit(const ProductsState.loading());
    } else {
      emit(ProductsState.success(
          products: List.of(products), isLoadingMore: true));
    }

    final result = await _userService.getAllProducts(skip: skip);
    result.fold(
      (error) {
        if (products.isEmpty) {
          emit(ProductsState.error(errorResponse: error));
        } else {
          emit(ProductsState.success(
              products: List.of(products), isLoadingMore: false));
        }
      },
      (response) {
        products.addAll(response.products);
        skip += limit;
        hasMore = response.products.length == limit;
        emit(ProductsState.success(
            products: List.of(products), isLoadingMore: false));
      },
    );
    isLoading = false;
  }
}
