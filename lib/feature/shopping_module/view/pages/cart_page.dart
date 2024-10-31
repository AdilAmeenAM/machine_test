import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_api/feature/shopping_module/controller/bloc/product_bloc.dart';
import 'package:product_api/feature/shopping_module/controller/bloc/product_bloc_events.dart';
import 'package:product_api/feature/shopping_module/controller/bloc/product_bloc_state.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cart")),
      body: BlocBuilder<ProductBloc, ProductBlocState>(
        builder: (context, state) {
          if (state.cartItems.isEmpty) {
            return const Center(child: Text("Your cart is empty"));
          }

          return ListView.builder(
            itemCount: state.cartItems.length,
            itemBuilder: (context, index) {
              final product = state.cartItems[index];
              return ListTile(
                leading: Image.network(product.imageUrl),
                title: Text(product.name),
                subtitle: Text("Price: ${product.price}"),
                trailing: IconButton(
                  icon: const Icon(Icons.remove_shopping_cart),
                  onPressed: () {
                    BlocProvider.of<ProductBloc>(context)
                        .add(RemoveFromCartEvent(product: product));
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
