import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_api/feature/products/controller/bloc/product_bloc.dart';
import 'package:product_api/feature/products/controller/bloc/product_bloc_state.dart';
import 'package:product_api/feature/products/view/pages/cart_page.dart';
import 'package:product_api/feature/products/view/pages/product_details_page.dart';
import 'package:product_api/feature/products/view/widgets/product_grid_item_widget.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    /// A callback to execute when the user click the cart button
    void onCartBtnPressed() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CartPage()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: onCartBtnPressed,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<ProductBloc, ProductBlocState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.errorMessage != null) {
              return Center(child: Text(state.errorMessage!));
            } else {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 320,
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProducDetailsPage(product: product),
                        ),
                      );
                    },
                    child: ProductGridItemWidget(product: product),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
