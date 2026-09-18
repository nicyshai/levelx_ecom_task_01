import 'RespProducts.dart';
class CartItem {
  final Products product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  num get id => product.id ?? 0;

  String get title => product.title ?? 'Unknown product';

  double get unitPrice => (product.price ?? 0).toDouble();

  double get lineTotal => unitPrice * quantity;


  CartItem copy() => CartItem(product: product, quantity: quantity);
}
