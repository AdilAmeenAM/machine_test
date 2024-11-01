import 'dart:convert';

import 'package:http/http.dart' as http;

class Product {
  final String id;
  final String name;
  final String description;
  final String stockStatus;
  final String quantity;
  final String price;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.stockStatus,
    required this.quantity,
    required this.price,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? 'No description available',
      stockStatus: json['stock_status'],
      quantity: json['quantity'],
      price: json['price'],
      imageUrl: 'https://mansharcart.com/image/${json['thumb']}',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'stock_status': stockStatus,
      'quantity': quantity,
      'price': price,
      'thumb': imageUrl.replaceFirst('https://mansharcart.com/image/', ''),
    };
  }

  /// Fetch products from the API
  ///
  /// Returns the products as a list
  static Future<List<Product>> fetchProducts() async {
    const String url =
        'https://mansharcart.com/api/products/category/139/key/123456789';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['products'] as List)
          .map((json) => Product.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
