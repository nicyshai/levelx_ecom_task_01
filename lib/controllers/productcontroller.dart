
import 'package:flutter/material.dart';

import '../models/RespProducts.dart';
import '../service/apiservice.dart';
import '../service/database_helper.dart';




class Productcontroller  extends ChangeNotifier{
  Apiservice apiservice=Apiservice();
  DatabaseService databaseService = DatabaseService();
  List<Products>? plist=[];
  bool isloading=false;

  void toggleloading(){
    isloading=!isloading;
    notifyListeners();

  }
  Future<void> fetchproducts() async {
    try {
      toggleloading();
      

      final offlineData = await databaseService.getOfflineProducts();
      if (offlineData.isNotEmpty) {
        plist = offlineData;
        notifyListeners();
      }


      final networkProducts = await apiservice.getproducts();
      
      if (networkProducts != null && networkProducts.isNotEmpty) {
        plist = networkProducts;
        notifyListeners();
        

        databaseService.saveOfflineProducts(networkProducts).then((_) {
          print("Offline cache updated successfully");
        }).catchError((e) {
          print("Failed to update offline cache: $e");
        });
      }
      
      toggleloading();
    } catch (e) {
      print("Error in fetchproducts: ${e.toString()}");
      

      if (plist == null || plist!.isEmpty) {
        plist = await databaseService.getOfflineProducts();
      }

      toggleloading();
    }
  }
}


