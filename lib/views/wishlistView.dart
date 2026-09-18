import 'package:ecom_test2/controllers/wishlistcontroller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecom_test2/views/productDetailView.dart';

class Wishlistview extends StatelessWidget {
  const Wishlistview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          "My Wishlist",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Consumer<Wishlistcontroller>(
        builder: (context, wishlist, child) {
          if (wishlist.wlist == null || wishlist.wlist!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 80,
                    color: Colors.grey.shade400,
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    "Your Wishlist is Empty",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Add your favorite products here",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: wishlist.wlist!.length,
            itemBuilder: (BuildContext context, int index) {
              final product = wishlist.wlist![index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Productdetailview(product: product),
                    ),
                  );
                },

                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),

                  child: Row(
                    children: [
                      // Product Image
                      Container(
                        height: 110,
                        width: 110,
                        padding: const EdgeInsets.all(8),

                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),

                        child: Image.network(
                          product.thumbnail!,
                          fit: BoxFit.contain,
                        ),
                      ),

                      const SizedBox(width: 15),

                      // Product Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,

                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              "₹${product.price}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 18,
                                  color: Colors.amber,
                                ),

                                const SizedBox(width: 4),

                                Text(
                                  "${product.rating}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          wishlist.toggleWishlist(product);
                        },

                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}