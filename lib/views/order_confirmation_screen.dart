import 'package:ecom_test2/views/mainView.dart';
import 'package:flutter/material.dart';
import 'package:ecom_test2/models/order_details.dart';
import 'package:ecom_test2/utils/formatters.dart';
import 'package:ecom_test2/widgets/section_card.dart';

class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({super.key, required this.order});

  final OrderDetails order;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) _continueShopping(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Order Confirmed'),
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final horizontal = constraints.maxWidth >= 800
                  ? constraints.maxWidth * 0.18
                  : 16.0;
              return ListView(
                padding: EdgeInsets.fromLTRB(horizontal, 20, horizontal, 28),
                children: [
                  Center(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color(0x1F4CAF50),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.check_circle,
                              size: 66, color: Colors.green),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          'Order placed successfully!',
                          textAlign: TextAlign.center,
                          style: textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Thank you, ${order.fullName}. Your order is on its way.',
                          textAlign: TextAlign.center,
                          style: textTheme.bodyMedium
                              ?.copyWith(color: scheme.onSurfaceVariant),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          Formatters.price(order.total),
                          style: textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: scheme.primary,
                          ),
                        ),
                        Text('Order Total',
                            style: textTheme.labelMedium
                                ?.copyWith(color: scheme.onSurfaceVariant)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 26),
                  SectionCard(
                    title: 'Order Information',
                    child: Column(
                      children: [
                        SummaryRow(label: 'Order ID', value: order.orderId),
                        SummaryRow(
                            label: 'Order Date',
                            value: Formatters.dateTime(order.placedAt)),
                        SummaryRow(
                            label: 'Items', value: '${order.itemCount}'),
                        SummaryRow(
                            label: 'Payment', value: 'Cash on Delivery'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  SectionCard(
                    title: 'Delivery Address',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(order.fullName,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600)),
                        const SizedBox(height: 4),
                        Text(order.fullAddress,
                            style: textTheme.bodyMedium
                                ?.copyWith(color: scheme.onSurfaceVariant)),
                        const SizedBox(height: 4),
                        Text('Phone: ${order.phone}',
                            style: textTheme.bodyMedium
                                ?.copyWith(color: scheme.onSurfaceVariant)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  SectionCard(
                    title: 'Items Ordered',
                    child: Column(
                      children: [
                        ...order.items.map(
                          (item) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${item.title}  x${item.quantity}',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(Formatters.price(item.lineTotal)),
                              ],
                            ),
                          ),
                        ),
                        const Divider(height: 22),
                        SummaryRow(
                            label: 'Subtotal',
                            value: Formatters.price(order.subtotal)),
                        SummaryRow(
                          label: 'Delivery',
                          value: order.deliveryFee == 0
                              ? 'Free'
                              : Formatters.price(order.deliveryFee),
                        ),
                        const Divider(height: 22),
                        SummaryRow(
                          label: 'Total Paid',
                          value: Formatters.price(order.total),
                          emphasised: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: () => _continueShopping(context),
                    icon: const Icon(Icons.storefront_outlined),
                    label: const Text('Continue Shopping'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
  void _continueShopping(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const Mainview()),
      (route) => false,
    );
  }
}
