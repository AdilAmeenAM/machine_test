import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_api/core/feature/shopping_module/controller/bloc/product_bloc_events.dart';
import 'package:product_api/core/feature/shopping_module/controller/bloc/product_bloc_state.dart';
import 'package:product_api/core/feature/shopping_module/model/product_model.dart';

// final class ProductBloc extends Bloc<ProductBlocEvents, ProductBlocState> {
//   ProductBloc() : super(const ProductBlocState(products: [], cartItems: [])) {
//     on<FetchProductsEvent>(fetchProducts);
//      on<AddToCartEvent>(_onAddToCart);
//     on<RemoveFromCartEvent>(_onRemoveFromCart);
//   }

//   Future<void> fetchProducts(
//       FetchProductsEvent event, Emitter<ProductBlocState> emit) async {
//     // Start loading
//     emit(ProductBlocState(products: state.products, isLoading: true));

//     try {
//       // Fetch products from API
//       final products = await Products.fetchProducts();

//       // Emit the loaded state with the fetched products
//       emit(ProductBlocState(products: products));
//     } catch (e) {
//       // Emit error state if API call fails
//       emit(ProductBlocState(products: [], errorMessage: e.toString()));
//     }
//   }

//    void _onAddToCart(AddToCartEvent event, Emitter<ProductBlocState> emit) {
//     final updatedCart = List<Products>.from(state.cartItems)..add(event.product);
//     emit(ProductBlocState(cartItems: updatedCart));
//   }
//    void _onRemoveFromCart(RemoveFromCartEvent event, Emitter<ProductBlocState> emit) {
//     final updatedCart = List<Products>.from(state.cartItems)..remove(event.product);
//     emit(ProductBlocState(cartItems: updatedCart));
//   }
// }


final class ProductBloc extends Bloc<ProductBlocEvents, ProductBlocState> {
  ProductBloc() : super(const ProductBlocState(products: [], cartItems: [])) {
    on<FetchProductsEvent>(_fetchProducts);
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
  }

  Future<void> _fetchProducts(
      FetchProductsEvent event, Emitter<ProductBlocState> emit) async {
    // Start loading
    emit(ProductBlocState(
      products: state.products,
      cartItems: state.cartItems,
      isLoading: true,
    ));

    try {
      // Fetch products from API
      final products = await Products.fetchProducts();

      // Emit the loaded state with the fetched products
      emit(ProductBlocState(
        products: products,
        cartItems: state.cartItems,
        isLoading: false,
      ));
    } catch (e) {
      // Emit error state if API call fails
      emit(ProductBlocState(
        products: state.products,
        cartItems: state.cartItems,
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onAddToCart(AddToCartEvent event, Emitter<ProductBlocState> emit) {
    final updatedCart = List<Products>.from(state.cartItems)..add(event.product);

    emit(ProductBlocState(
      products: state.products, // Preserve existing products
      cartItems: updatedCart,   // Update cart items
      isLoading: state.isLoading, 
      errorMessage: state.errorMessage,
    ));
  }

  void _onRemoveFromCart(RemoveFromCartEvent event, Emitter<ProductBlocState> emit) {
    final updatedCart = List<Products>.from(state.cartItems)..remove(event.product);

    emit(ProductBlocState(
      products: state.products,  // Preserve existing products
      cartItems: updatedCart,    // Update cart items
      isLoading: state.isLoading,
      errorMessage: state.errorMessage,
    ));
  }
}
