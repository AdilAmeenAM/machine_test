import 'package:product_api/feature/shopping_module/model/product_model.dart';

final class ProductBlocState {
  final List<Products> products;
  final bool isLoading;
  final String? errorMessage;
  final List<Products> cartItems;

  const ProductBlocState({
    required this.cartItems,
    required this.products,
    this.isLoading = false,
    this.errorMessage,
  });
}
