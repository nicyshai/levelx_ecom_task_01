import 'cart_item.dart';

class OrderDetails {
  final String orderId;
  final String fullName;
  final String phone;
  final String address;
  final String city;
  final String pincode;
  final List<CartItem> items;
  final double subtotal;
  final double deliveryFee;
  final double total;
  final DateTime placedAt;

  OrderDetails({
    required this.orderId,
    required this.fullName,
    required this.phone,
    required this.address,
    required this.city,
    required this.pincode,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.placedAt,
  });

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  String get fullAddress => '$address, $city - $pincode';
}
