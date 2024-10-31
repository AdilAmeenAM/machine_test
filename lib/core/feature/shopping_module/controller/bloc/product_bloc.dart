import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_api/core/feature/shopping_module/controller/bloc/product_bloc_events.dart';
import 'package:product_api/core/feature/shopping_module/controller/bloc/product_bloc_state.dart';
import 'package:product_api/core/feature/shopping_module/model/product_model.dart';

final class ProductBloc extends Bloc<ProductBlocEvents, ProductBlocState> {
  ProductBloc() : super(const ProductBlocState(products: [])) {
    on<FetchProductsEvent>(fetchProducts);
  }

  Future<void> fetchProducts(
      FetchProductsEvent event, Emitter<ProductBlocState> emit) async {
    // Start loading
    emit(ProductBlocState(products: state.products, isLoading: true));

    try {
      // Fetch products from API
      final products = await Products.fetchProducts();

      // Emit the loaded state with the fetched products
      emit(ProductBlocState(products: products));
    } catch (e) {
      // Emit error state if API call fails
      emit(ProductBlocState(products: [], errorMessage: e.toString()));
    }
  }
}
