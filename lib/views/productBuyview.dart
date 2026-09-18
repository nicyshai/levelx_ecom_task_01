import 'package:ecom_test2/models/RespProducts.dart';
import 'package:ecom_test2/views/homeView.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Productbuyview extends StatefulWidget {
  final Products product;
  final int quantity;

  const Productbuyview({
    super.key,
    required this.product,
    required this.quantity,
  });

  @override
  State<Productbuyview> createState() => _ProductbuyviewState();
}

class _ProductbuyviewState extends State<Productbuyview> {
  bool isBought = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isBought) {
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const Homeview(),
            ),
                (route) => false,
          );
        }
      });
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          "Buy Product",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),

          child: isBought
              ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset("assets/json/success.json",width: 200,height: 200,repeat: false,fit: .contain),



              const SizedBox(height: 20),

              const Text(
                "Buy Successfully!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Your product has been purchased successfully",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            ],
          )
              : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 180,
                width: 180,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.network(
                  widget.product.thumbnail!,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                widget.product.title!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                "₹${widget.product.price}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "Quantity: ${widget.quantity}",
                style: const TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 8),

              Text(
                "Total: ₹${widget.product.price! * widget.quantity}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isBought = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Buy Now",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}