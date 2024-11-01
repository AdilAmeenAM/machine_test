import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_api/feature/products/controller/bloc/product_bloc.dart';
import 'package:product_api/feature/products/controller/bloc/product_bloc_events.dart';
import 'package:product_api/feature/products/model/product_model.dart';

class ProductGridItemWidget extends StatelessWidget {
  const ProductGridItemWidget({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    // Define the function for the ElevatedButton callback
    void addToCartCallback(Product product) {
      BlocProvider.of<ProductBloc>(context)
          .add(AddToCartEvent(product: product));
    }

    return Card(
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(product.imageUrl),
          ),
          const SizedBox(height: 8),
          Text(
            product.name,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            product.price,
            style: const TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            product.stockStatus,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              onPressed: () => addToCartCallback(product),
              child: const Text("Add to Cart"),
            ),
          ),
        ],
      ),
    );
  }
}
