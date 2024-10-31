import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_api/core/feature/shopping_module/controller/bloc/product_bloc.dart';
import 'package:product_api/core/feature/shopping_module/controller/bloc/product_bloc_events.dart';
import 'package:product_api/core/feature/shopping_module/controller/bloc/product_bloc_state.dart';
import 'package:product_api/core/feature/shopping_module/view/pages/cart_page.dart';
import 'package:product_api/core/feature/shopping_module/view/pages/product_details_page.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),
              );
            },
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
                  mainAxisExtent: 250,
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
                    child: Card(
                      child: Column(
                        children: [
                          Image.network(product.imageUrl),
                          Text(
                            product.name,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            product.price,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            product.stockStatus,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                            ),
                          ),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                // BlocProvider.of<ProductBloc>(context)
                                //     .add(AddToCartEvent(product: product));
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   SnackBar(
                                //       content: Text(
                                //           "${product.name} added to cart!")),
                                // );

                                // Access the current cart items from the ProductBloc state
                                final cartItems =
                                    BlocProvider.of<ProductBloc>(context)
                                        .state
                                        .cartItems;

                                // Check if the product is already in the cart
                                if (cartItems.contains(product)) {
                                  // If product is already in the cart, show snackbar message
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "${product.name} is already in the cart!")),
                                  );
                                } else {
                                  // If product is not in the cart, add it and show confirmation
                                  BlocProvider.of<ProductBloc>(context)
                                      .add(AddToCartEvent(product: product));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "${product.name} added to cart!")),
                                  );
                                }
                              },
                              child: const Text("Add to Cart"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // child: Card(
                    //   elevation: 2,
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(10),
                    //   ),
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.stretch,
                    //       children: [
                    //         AspectRatio(
                    //           aspectRatio: 1,
                    //           child: Image.network(
                    //             product.imageUrl,
                    //             fit: BoxFit.cover,
                    //           ),
                    //         ),
                    //         const SizedBox(height: 8),
                    //         Text(
                    //           product.name,
                    //           style: const TextStyle(
                    //             fontSize: 14,
                    //             fontWeight: FontWeight.w600,
                    //           ),
                    //           maxLines: 2,
                    //           overflow: TextOverflow.ellipsis,
                    //         ),
                    //         const SizedBox(height: 4),
                    //         Text(
                    //           product.price,
                    //           style: const TextStyle(
                    //             fontSize: 14,
                    //             color: Colors.green,
                    //             fontWeight: FontWeight.bold,
                    //           ),
                    //         ),
                    //         const SizedBox(height: 4),
                    //         Text(
                    //           product.stockStatus,
                    //           style: TextStyle(
                    //             fontSize: 12,
                    //             color: Colors.grey[700],
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  // Widget build(BuildContext context) {
  //   return BlocProvider(
  //     create: (context) => ProductBloc()..add(FetchProductsEvent()),
  //     child: Scaffold(
  //       appBar: AppBar(title: const Text("Products")),
  //       body: BlocBuilder<ProductBloc, ProductBlocState>(
  //         builder: (context, state) {
  //           if (state.isLoading) {
  //             return const Center(child: CircularProgressIndicator());
  //           } else if (state.errorMessage != null) {
  //             return Center(child: Text(state.errorMessage!));
  //           } else {
  //             // Determine the number of columns based on screen width
  //             final screenWidth = MediaQuery.of(context).size.width;
  //             final crossAxisCount = screenWidth < 600 ? 2 : 4;

  //             return Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: GridView.builder(
  //                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //                   mainAxisExtent: 250,
  //                   crossAxisCount: crossAxisCount,
  //                   crossAxisSpacing: 8,
  //                   mainAxisSpacing: 8,
  //                   childAspectRatio: 0.7,
  //                 ),
  //                 itemCount: state.products.length,
  //                 itemBuilder: (context, index) {
  //                   final product = state.products[index];
  //                   return GestureDetector(
  //                     onTap: () {
  //                       Navigator.push(
  //                         context,
  //                         MaterialPageRoute(
  //                           builder: (context) =>
  //                               ProducDetailsPage(product: product),
  //                         ),
  //                       );
  //                     },
  //                     child: Card(
  //                       elevation: 2,
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(10),
  //                       ),
  //                       child: Padding(
  //                         padding: const EdgeInsets.all(8.0),
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.stretch,
  //                           children: [
  //                             AspectRatio(
  //                               aspectRatio: 1,
  //                               child: Image.network(
  //                                 product.imageUrl,
  //                                 fit: BoxFit.cover,
  //                               ),
  //                             ),
  //                             const SizedBox(height: 8),
  //                             Text(
  //                               product.name,
  //                               style: const TextStyle(
  //                                 fontSize: 14,
  //                                 fontWeight: FontWeight.w600,
  //                               ),
  //                               maxLines: 2,
  //                               overflow: TextOverflow.ellipsis,
  //                             ),
  //                             const SizedBox(height: 4),
  //                             Text(
  //                               product.price,
  //                               style: const TextStyle(
  //                                 fontSize: 14,
  //                                 color: Colors.green,
  //                                 fontWeight: FontWeight.bold,
  //                               ),
  //                             ),
  //                             const SizedBox(height: 4),
  //                             Text(
  //                               product.stockStatus,
  //                               style: TextStyle(
  //                                 fontSize: 12,
  //                                 color: Colors.grey[700],
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   );
  //                 },
  //               ),
  //             );
  //           }
  //         },
  //       ),
  //     ),
  //   );
  // }
}
