import 'package:product_api/feature/products/model/product_model.dart';

final class ProductBlocState {
  final List<Product> products;
  final bool isLoading;
  final String? errorMessage;
  final List<Product> cartItems;

  const ProductBlocState({
    required this.cartItems,
    required this.products,
    this.isLoading = false,
    this.errorMessage,
  });
}
