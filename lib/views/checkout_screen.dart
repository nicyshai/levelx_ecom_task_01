import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ecom_test2/models/order_details.dart';
import 'package:ecom_test2/controllers/cartcontroller.dart';
import 'package:ecom_test2/views/order_confirmation_screen.dart';
import 'package:ecom_test2/utils/formatters.dart';
import 'package:ecom_test2/widgets/section_card.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  static const routeName = '/checkout';

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _pincodeController = TextEditingController();

  bool _placingOrder = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _pincodeController.dispose();
    super.dispose();
  }

  Future<void> _confirmOrder() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    final cart = context.read<Cartcontroller>();
    if (cart.isEmpty) return;

    setState(() => _placingOrder = true);

    await Future.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;

    final order = OrderDetails(
      orderId: 'ORD${DateTime.now().millisecondsSinceEpoch.toString().substring(6)}',
      fullName: _nameController.text.trim(),
      phone: _phoneController.text.trim(),
      address: _addressController.text.trim(),
      city: _cityController.text.trim(),
      pincode: _pincodeController.text.trim(),
      items: cart.snapshot(),
      subtotal: cart.subtotal,
      deliveryFee: cart.deliveryFee,
      total: cart.total,
      placedAt: DateTime.now(),
    );

    cart.clearCart();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => OrderConfirmationScreen(order: order),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<Cartcontroller>();
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontal =
                constraints.maxWidth >= 800 ? constraints.maxWidth * 0.15 : 16.0;
            return Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: ListView(
                padding: EdgeInsets.fromLTRB(horizontal, 12, horizontal, 28),
                children: [
                  SectionCard(
                    title: 'Delivery Information',
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: TextFormField(
                            controller: _nameController,
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Full Name',
                              prefixIcon: Icon(Icons.person_outline),
                            ),
                            validator: (value) {
                              final text = (value ?? '').trim();
                              if (text.isEmpty) return 'Full name is required';
                              if (text.length < 3) {
                                return 'Enter at least 3 characters';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Phone Number',
                              prefixIcon: Icon(Icons.phone_outlined),
                            ),
                            validator: (value) {
                              final text = (value ?? '').trim();
                              if (text.isEmpty) return 'Phone number is required';
                              if (text.length != 10) {
                                return 'Enter a valid 10 digit phone number';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: TextFormField(
                            controller: _addressController,
                            maxLines: 3,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Address',
                              prefixIcon: Icon(Icons.home_outlined),
                              alignLabelWithHint: true,
                            ),
                            validator: (value) {
                              final text = (value ?? '').trim();
                              if (text.isEmpty) return 'Address is required';
                              if (text.length < 6) {
                                return 'Please enter a complete address';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: TextFormField(
                            controller: _cityController,
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'City',
                              prefixIcon: Icon(Icons.location_city_outlined),
                            ),
                            validator: (value) =>
                                (value ?? '').trim().isEmpty ? 'City is required' : null,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: TextFormField(
                            controller: _pincodeController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(6),
                            ],
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Pincode',
                              prefixIcon: Icon(Icons.markunread_mailbox_outlined),
                            ),
                            validator: (value) {
                              final text = (value ?? '').trim();
                              if (text.isEmpty) return 'Pincode is required';
                              if (text.length != 6) {
                                return 'Enter a valid 6 digit pincode';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  SectionCard(
                    title: 'Order Summary',
                    child: Column(
                      children: [
                        ...cart.items.map(
                          (item) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(item.title,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis),
                                      Text(
                                        'Qty ${item.quantity} x ${Formatters.price(item.unitPrice)}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                                color: scheme.onSurfaceVariant),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(Formatters.price(item.lineTotal),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                        ),
                        const Divider(height: 22),
                        SummaryRow(
                          label: 'Subtotal',
                          value: Formatters.price(cart.subtotal),
                        ),
                        SummaryRow(
                          label: 'Delivery',
                          value: cart.deliveryFee == 0
                              ? 'Free'
                              : Formatters.price(cart.deliveryFee),
                        ),
                        const Divider(height: 22),
                        SummaryRow(
                          label: 'Total Order Amount',
                          value: Formatters.price(cart.total),
                          emphasised: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  FilledButton(
                    onPressed: _placingOrder || cart.isEmpty ? null : _confirmOrder,
                    child: _placingOrder
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                                strokeWidth: 2.4, color: Colors.white),
                          )
                        : const Text('Confirm Order'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
