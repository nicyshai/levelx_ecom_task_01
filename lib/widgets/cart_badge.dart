import 'package:ecom_test2/controllers/cartcontroller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CartBadgeButton extends StatelessWidget {
  const CartBadgeButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final count = context.select<Cartcontroller, int>((c) => c.totalQuantity);
    final scheme = Theme.of(context).colorScheme;

    return Stack(
      alignment: Alignment.center,
      children: [
        IconButton(
          onPressed: onPressed,
          tooltip: 'View cart',
          icon: const Icon(Icons.shopping_cart_outlined),
        ),
        if (count > 0)
          Positioned(
            top: 6,
            right: 6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
              constraints: const BoxConstraints(minWidth: 17),
              decoration: BoxDecoration(
                color: scheme.error,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                count > 99 ? '99+' : '$count',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: scheme.onError,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
