import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:product_api/feature/products/controller/bloc/product_bloc_events.dart';
import 'package:product_api/feature/products/controller/bloc/product_bloc_state.dart';
import 'package:product_api/feature/products/model/product_model.dart';
import 'package:product_api/main.dart';

final class ProductBloc extends Bloc<ProductBlocEvents, ProductBlocState> {
  static final _storage = GetStorage('cart');

  ProductBloc() : super(const ProductBlocState(products: [], cartItems: [])) {
    on<FetchProductsEvent>(_fetchProducts);
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
  }

  /// Load the cart data from cache
  ///
  /// Returns the cart item that are cached
  List<Product> _loadCartCache() {
    final productsCache = _storage.getValues();
    final List<Product> cartItems = [];

    for (final cacheItem in productsCache) {
      cartItems.add(Product.fromJson(cacheItem));
    }

    return cartItems;
  }

  Future<void> _fetchProducts(
      FetchProductsEvent event, Emitter<ProductBlocState> emit) async {
    /// Get the cached cart items
    final cartItems = _loadCartCache();

    // Start loading
    emit(ProductBlocState(
      products: state.products,
      cartItems: cartItems,
      isLoading: true,
    ));

    try {
      // Fetch products from API
      final products = await Product.fetchProducts();

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
    /// Check if the product is already in the cart
    if (state.cartItems.any((product) => product.id == event.product.id)) {
      /// If product is already in the cart, show already exists message
      App.scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
          content:
              Text("${event.product.name.trim()} is already in the cart!")));
      return;
    }

    final updatedCart = List<Product>.from(state.cartItems)..add(event.product);

    /// Update the cart details to the local storage
    _updateCartCache(updatedCart);

    emit(ProductBlocState(
      products: state.products, // Preserve existing products
      cartItems: updatedCart, // Update cart items
      isLoading: state.isLoading,
      errorMessage: state.errorMessage,
    ));

    // If product is not in the cart, add it and show confirmation
    App.scaffoldMessengerKey.currentState!.showSnackBar(
        SnackBar(content: Text("${event.product.name.trim()} added to cart!")));
  }

  void _onRemoveFromCart(
      RemoveFromCartEvent event, Emitter<ProductBlocState> emit) {
    final updatedCart = List<Product>.from(state.cartItems)
      ..remove(event.product);

    /// Update the cart cache
    _updateCartCache(updatedCart);

    emit(ProductBlocState(
      products: state.products, // Preserve existing products
      cartItems: updatedCart, // Update cart items
      isLoading: state.isLoading,
      errorMessage: state.errorMessage,
    ));
  }

  /// Update the cart products cache in the local storage
  Future<void> _updateCartCache(List<Product> products) async {
    await _storage.erase();

    for (final product in products) {
      await _storage.write(product.id, product.toJson());
    }
  }
}
