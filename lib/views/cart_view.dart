import 'package:ecom_test2/controllers/cartcontroller.dart';
import 'package:ecom_test2/models/RespProducts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecom_test2/views/productDetailView.dart';
import 'package:ecom_test2/views/checkout_screen.dart';
import 'package:sliding_action_button/sliding_action_button.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          "My Cart",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),

      body: Consumer<Cartcontroller>(
        builder: (context, cart, child) {

          if (cart.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: Colors.grey.shade400,
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    "Your Cart is Empty",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Add products to your cart",
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),

                  const SizedBox(height: 18),

                  ElevatedButton.icon(
                    onPressed: () => Navigator.maybePop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                    ),
                    icon: const Icon(Icons.storefront_outlined),
                    label: const Text("Continue Shopping"),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: cart.items.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = cart.items[index];
                    final product = item.product;
                    final quantity = item.quantity;

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
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),

                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Container(
                              height: 120,
                              width: 120,
                              padding: const EdgeInsets.all(8),

                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(14),
                              ),

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

                            const SizedBox(width: 15),


                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${product.title}",
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
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurple,
                                    ),
                                  ),

                                  const SizedBox(height: 5),

                                  Text(
                                    "Subtotal: ₹${((product.price ?? 0) * quantity).toStringAsFixed(2)}",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),

                                  const SizedBox(height: 10),


                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey.shade300,
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                cart.decreaseQuantity(product.id!);
                                              },
                                              icon: const Icon(
                                                Icons.remove,
                                                size: 18,
                                              ),
                                            ),

                                            Text(
                                              "$quantity",
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),

                                            IconButton(
                                              onPressed: () {
                                                cart.increaseQuantity(product.id!);
                                              },
                                              icon: const Icon(
                                                Icons.add,
                                                size: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      const SizedBox(width: 8),

                                      IconButton(
                                        onPressed: () {
                                          cart.removeFromCart(product.id!);
                                        },
                                        icon: const Icon(
                                          Icons.delete_outline,
                                          color: Colors.red,
                                          size: 28,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),


              Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 18,
                ),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Cart Items: ${cart.totalQuantity}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          "Total Amount",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),

                    Text(
                      "₹${cart.total.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ],
                ),
              ),


              Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                height: 55,

                child: SlideToActionButton(
                  slideButtonShape: SlideButtonShape.square,
                  initialSlidingActionLabel: 'Slide to checkout',
                  finalSlidingActionLabel: '✓ Opening checkout',
                  enabledTrackDecoration: SlideTrackDecoration.fromGradient(
                    const LinearGradient(
                      colors: [Colors.purple, Colors.deepPurple],
                    ),
                  ),
                  disabledTrackDecoration:
                  SlideTrackDecoration.fromColor(Colors.grey),
                  thumbIcon:
                  const Icon(Icons.shopping_bag, color: Colors.deepPurple),
                  onSlideActionCompleted: () {

                    Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => const CheckoutScreen(),
          ),
          );

                  },
                ),
              ),


            ],
          );
        },
      ),
    );
  }
}
