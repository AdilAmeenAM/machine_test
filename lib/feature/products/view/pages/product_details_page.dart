import 'package:flutter/material.dart';
import 'package:product_api/feature/products/model/product_model.dart';

class ProducDetailsPage extends StatelessWidget {
  final Product product;

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
                  height: 24,
                ),
                Image.network(
                  product.imageUrl,
                  height: 350,
                  width: 350,
                  fit: BoxFit.cover,
                ),
                Text(product.name,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold)),
                Text(
                  "Price: ${product.price}",
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("Stock Status: ${product.stockStatus}"),
                Text("Quantity: ${product.quantity}"),
                Text(product.description),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
