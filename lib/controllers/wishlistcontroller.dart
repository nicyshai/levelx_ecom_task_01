import 'package:flutter/material.dart';

import '../models/RespProducts.dart';

class Wishlistcontroller extends ChangeNotifier{
  List<Products>? wlist=[];
  bool wishtoggle=false;


  void toggleWishlist(Products product) {
    if (wlist?.contains(product) ?? false) {
      wlist?.remove(product);
      wishtoggle = false;
    } else {
      wlist?.add(product);
      wishtoggle = true;
    }

    notifyListeners();
  }
   
  bool isWishlisted(Products product) {
    return wlist?.contains(product) ?? false;
  }
}
