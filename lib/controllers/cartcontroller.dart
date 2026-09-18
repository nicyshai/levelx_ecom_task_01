import 'package:flutter/foundation.dart';
import 'package:ecom_test2/models/RespProducts.dart';
import 'package:ecom_test2/models/cart_item.dart';


class Cartcontroller extends ChangeNotifier {
  final Map<num, CartItem> _items = {};

  static const double freeDeliveryThreshold = 500;
  static const double standardDeliveryFee = 40;

  List<CartItem> get items => _items.values.toList();

  bool get isEmpty => _items.isEmpty;

  int get distinctItemCount => _items.length;

  int get totalQuantity =>
      _items.values.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal =>
      _items.values.fold(0.0, (sum, item) => sum + item.lineTotal);

  double get deliveryFee =>
      (isEmpty || subtotal >= freeDeliveryThreshold) ? 0 : standardDeliveryFee;

  double get total => subtotal + deliveryFee;

  bool contains(num? productId) => _items.containsKey(productId ?? -1);

  int quantityOf(num? productId) => _items[productId ?? -1]?.quantity ?? 0;

  void addToCart(Products product, {int quantity = 1}) {
    final id = product.id;
    if (id == null) return;

    if (_items.containsKey(id)) {
      _items[id]!.quantity += quantity;
    } else {
      _items[id] = CartItem(product: product, quantity: quantity);
    }
    notifyListeners();
  }

  void increaseQuantity(num productId) {
    final item = _items[productId];
    if (item == null) return;
    item.quantity += 1;
    notifyListeners();
  }


  void decreaseQuantity(num productId) {
    final item = _items[productId];
    if (item == null) return;
    if (item.quantity > 1) {
      item.quantity -= 1;
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void removeFromCart(num productId) {
    _items.remove(productId);
    notifyListeners();
  }


  List<CartItem> snapshot() =>
      _items.values.map((item) => item.copy()).toList();

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
