import 'package:ecom_test2/models/RespProducts.dart';
import 'package:ecom_test2/controllers/cartcontroller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Productdetailview extends StatelessWidget {
  final Products product;

  const Productdetailview({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          "Product Details",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              Center(
                child: Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: product.thumbnailBlob != null
                      ? Image.memory(
                          product.thumbnailBlob!,
                          fit: BoxFit.contain,
                        )
                      : Image.network(
                          product.thumbnail!,
                          fit: BoxFit.contain,
                        ),
                ),
              ),

              const SizedBox(height: 20),


              Text(
                product.title!,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),


              Text(
                "₹${product.price}",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 22,
                  ),

                  const SizedBox(width: 5),

                  Text(
                    "${product.rating}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),


              const Text(
                "Description",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                product.description!,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade700,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 20),


              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(15),

                  child: Column(
                    children: [


                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Brand",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text("${product.brand}"),
                        ],
                      ),

                      const Divider(),


                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Stock",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text("${product.stock}"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),


              SizedBox(
                width: double.infinity,
                height: 50,

                child: ElevatedButton.icon(
                  onPressed: () {
                    Provider.of<Cartcontroller>(
                      context,
                      listen: false,
                    ).addToCart(product);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Product added to cart"),
                      ),
                    );
                  },

                  icon: const Icon(Icons.shopping_cart),

                  label: const Text(
                    "Add to Cart",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}