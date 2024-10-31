import 'package:flutter/material.dart';
import 'package:product_api/feature/shopping_module/model/product_model.dart';

class ProducDetailsPage extends StatelessWidget {
  final Products product;

  const ProducDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Image.network(product.imageUrl),
                Text(product.name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                Text("Price: ${product.price}"),
                Text("Stock Status: ${product.stockStatus}"),
                Text("Quantity: ${product.quantity}"),
                Text(product.description),
                ElevatedButton(
                  onPressed: () {
                    // Handle add to cart functionality here
                  },
                  child: const Text("Add to Cart"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
