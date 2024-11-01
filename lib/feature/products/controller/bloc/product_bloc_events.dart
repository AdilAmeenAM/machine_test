import 'package:product_api/feature/products/model/product_model.dart';

abstract class ProductBlocEvents {}

final class FetchProductsEvent extends ProductBlocEvents {}

final class AddToCartEvent extends ProductBlocEvents {
  final Product product;

  AddToCartEvent({required this.product});
}

final class RemoveFromCartEvent extends ProductBlocEvents {
  final Product product;

  RemoveFromCartEvent({required this.product});
}
