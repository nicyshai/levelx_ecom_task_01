import 'package:ecom_test2/controllers/cartcontroller.dart';
import 'package:ecom_test2/views/cart_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecom_test2/models/RespProducts.dart';
import 'package:ecom_test2/utils/formatters.dart';
import 'package:ecom_test2/widgets/cart_badge.dart';
import 'package:ecom_test2/widgets/product_image.dart';


class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});

  static const routeName = '/product-details';

  final Products product;

  void _addToCart(BuildContext context) {
    context.read<Cartcontroller>().addToCart(product);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('${product.title ?? 'Product'} added to cart'),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
          action: SnackBarAction(
            label: 'VIEW CART',
            onPressed: () =>
                Navigator.push(context,MaterialPageRoute(builder: (context) => const CartView(),)),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final quantityInCart =
        context.select<Cartcontroller, int>((c) => c.quantityOf(product.id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        actions: [
          CartBadgeButton(
            onPressed: () =>
                Navigator.push(context,MaterialPageRoute(builder: (context) => CartView(),) ),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 800;
            final image = ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: AspectRatio(
                aspectRatio: isWide ? 1 : 1.15,
                child: ProductImage(
                  url: (product.images != null && product.images!.isNotEmpty)
                      ? product.images!.first
                      : product.thumbnail,
                ),
              ),
            );

            final details = _details(context, textTheme, scheme);

            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              child: isWide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: image),
                        const SizedBox(width: 28),
                        Expanded(child: details),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        image,
                        const SizedBox(height: 18),
                        details,
                      ],
                    ),
            );
          },
        ),
      ),
      bottomNavigationBar: _bottomBar(context, scheme, quantityInCart),
    );
  }

  Widget _details(
      BuildContext context, TextTheme textTheme, ColorScheme scheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: scheme.primaryContainer,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            Formatters.category(product.category),
            style: textTheme.labelSmall?.copyWith(
              color: scheme.onPrimaryContainer,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          product.title ?? 'Untitled',
          style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              Formatters.price(product.price),
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: scheme.primary,
              ),
            ),
            const SizedBox(width: 12),
            if (product.rating != null) ...[
              Icon(Icons.star_rounded, size: 18, color: Colors.amber.shade700),
              const SizedBox(width: 3),
              Text(product.rating!.toStringAsFixed(1),
                  style: textTheme.bodyMedium),
            ],
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Description',
          style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6),
        Text(
          product.description ?? 'No description available.',
          style: textTheme.bodyMedium?.copyWith(
            color: scheme.onSurfaceVariant,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            if (product.brand != null)
              _infoChip(context, Icons.sell_outlined, product.brand!),
            if (product.availabilityStatus != null)
              _infoChip(context, Icons.inventory_2_outlined,
                  product.availabilityStatus!),
            if (product.shippingInformation != null)
              _infoChip(context, Icons.local_shipping_outlined,
                  product.shippingInformation!),
            if (product.warrantyInformation != null)
              _infoChip(context, Icons.verified_user_outlined,
                  product.warrantyInformation!),
          ],
        ),
      ],
    );
  }

  Widget _infoChip(BuildContext context, IconData icon, String label) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: scheme.onSurfaceVariant),
          const SizedBox(width: 6),
          Text(label, style: Theme.of(context).textTheme.labelMedium),
        ],
      ),
    );
  }

  Widget _bottomBar(
      BuildContext context, ColorScheme scheme, int quantityInCart) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: BoxDecoration(
        color: scheme.surface,
        border: Border(top: BorderSide(color: scheme.outlineVariant)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Price',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                        )),
                Text(
                  Formatters.price(product.price),
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: FilledButton.icon(
                onPressed: () => _addToCart(context),
                icon: const Icon(Icons.shopping_cart_checkout),
                label: Text(quantityInCart > 0
                    ? 'Add to Cart ($quantityInCart in cart)'
                    : 'Add to Cart'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
