import 'package:product_api/feature/shopping_module/model/product_model.dart';

abstract class ProductBlocEvents {}

final class FetchProductsEvent extends ProductBlocEvents {}

final class AddToCartEvent extends ProductBlocEvents {
  final Products product;

  AddToCartEvent({required this.product});
}

final class RemoveFromCartEvent extends ProductBlocEvents {
  final Products product;

  RemoveFromCartEvent({required this.product});
}
