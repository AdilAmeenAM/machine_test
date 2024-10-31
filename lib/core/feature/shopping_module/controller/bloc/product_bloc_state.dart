import 'package:product_api/core/feature/shopping_module/model/product_model.dart';

final class ProductBlocState {
  final List<Products> products;
  final bool isLoading;
  final String? errorMessage;

  const ProductBlocState({
    required this.products,
    this.isLoading = false,
    this.errorMessage,
  });
}
