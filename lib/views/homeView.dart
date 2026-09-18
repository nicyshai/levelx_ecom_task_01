import 'package:ecom_test2/views/cart_view.dart';

import 'package:ecom_test2/controllers/cartcontroller.dart';
import 'package:ecom_test2/controllers/wishlistcontroller.dart';
import 'package:ecom_test2/views/wishlistView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../controllers/productcontroller.dart';
import 'package:ecom_test2/views/productDetailView.dart';

class Homeview extends StatelessWidget {
  const Homeview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("WELCOME", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Wishlistview()),
              );
            },
            icon: Icon(Icons.favorite, color: Colors.white),
          ),

          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartView()),
              );
            },
            icon: Consumer<Cartcontroller>(
              builder: (context, cart, child) {
                return Stack(
                  children: [
                    const Icon(Icons.shopping_cart, color: Colors.white),

                    if (cart.totalQuantity > 0)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: CircleAvatar(
                          radius: 9,
                          backgroundColor: Colors.red,
                          child: Text(
                            "${cart.totalQuantity}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),

          ),
        ],
      ),
      body: Consumer<Productcontroller>(
        builder: (BuildContext context, value, Widget? child) {
          if (value.isloading == true) {
            return Center(child: CircularProgressIndicator());
          }
          if (value.plist == null || value.plist!.isEmpty) {
            return Center(child: Text("No data"));
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 200.0,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 0.8,
                        aspectRatio: 16 / 9,
                        initialPage: 0,
                      ),
                      items: value.plist!.take(5).map((product) {
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
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: product.thumbnailBlob != null
                                    ? Image.memory(
                                        product.thumbnailBlob!,
                                        fit: BoxFit.contain,
                                      )
                                    : Image.network(
                                        "${product.thumbnail}",
                                        fit: BoxFit.contain,
                                      ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: value.plist!.length,
                    itemBuilder: (BuildContext context, int index) {
                final product = value.plist![index];

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
                  child: Card(
                    color: Colors.white,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Expanded(
                                child: product.thumbnailBlob != null
                                    ? Image.memory(
                                        product.thumbnailBlob!,
                                        fit: BoxFit.contain,
                                      )
                                    : Image.network(
                                        "${product.thumbnail}",
                                        fit: BoxFit.contain,
                                      ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "${product.title}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text("₹ ${product.price}"),
                              const SizedBox(height: 4),
                              ElevatedButton(
                                onPressed: () {
                                  Provider.of<Cartcontroller>(
                                    context,
                                    listen: false,
                                  ).addToCart(product);
                                },
                                child: const Text("Add to cart"),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Consumer<Wishlistcontroller>(
                            builder: (context, wishlist, child) {
                              final isWishlisted = wishlist.isWishlisted(
                                product,
                              );
                              return IconButton(
                                onPressed: () {
                                  wishlist.toggleWishlist(product);
                                },
                                icon: Icon(
                                  isWishlisted
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isWishlisted
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
    }
  },
),
    );
  }
}
