import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/RespProducts.dart';

class DatabaseService {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    return await openDatabase(
      join(await getDatabasesPath(), "Product.db"),
      version: 4,
      onCreate: (Database db, version) async {
        await db.execute(
            "CREATE TABLE offline_products("
                "id INTEGER PRIMARY KEY,"
                "title TEXT,"
                "price REAL,"
                "thumbnail TEXT,"
                "thumbnail_blob BLOB,"
                "description TEXT,"
                "rating REAL,"
                "brand TEXT,"
                "stock INTEGER)"
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 4) {

          await db.execute("DROP TABLE IF EXISTS offline_products");
          await db.execute(
              "CREATE TABLE offline_products("
                  "id INTEGER PRIMARY KEY,"
                  "title TEXT,"
                  "price REAL,"
                  "thumbnail TEXT,"
                  "thumbnail_blob BLOB,"
                  "description TEXT,"
                  "rating REAL,"
                  "brand TEXT,"
                  "stock INTEGER)"
          );
        }
      },
    );
  }

  Future<Uint8List?> _fetchImageBytes(String url) async {
    try {
      final response = await Dio().get(
        url,
        options: Options(responseType: ResponseType.bytes),
      );
      if (response.statusCode == 200) {
        return Uint8List.fromList(response.data);
      }
    } catch (e) {
      print("Error fetching image bytes: $e");
    }
    return null;
  }


  Future<void> saveOfflineProducts(List<Products> products) async {
    final db = await database;


    await db.delete("offline_products");


    final productsToCache = products.take(10).toList();


    final List<Uint8List?> allImageBytes = await Future.wait(
      productsToCache.map((p) => (p.thumbnail != null && p.thumbnail!.isNotEmpty)
          ? _fetchImageBytes(p.thumbnail!) 
          : Future.value(null as Uint8List?))
    );

    final batch = db.batch();
    for (int i = 0; i < productsToCache.length; i++) {
      final product = productsToCache[i];
      final imageBytes = allImageBytes[i];

      batch.insert(
        "offline_products",
        {
          "id": product.id,
          "title": product.title,
          "price": product.price,
          "thumbnail": product.thumbnail,
          "thumbnail_blob": imageBytes,
          "description": product.description,
          "rating": product.rating,
          "brand": product.brand,
          "stock": product.stock,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }


  Future<List<Products>> getOfflineProducts() async {
    final db = await database;

    final List<Map<String, Object?>> maps = await db.query(
      "offline_products",
      limit: 10,
    );

    return maps.map((product) {
      return Products(
        id: product['id'] as num?,
        title: product['title'] as String?,
        price: product['price'] as num?,
        thumbnail: product['thumbnail'] as String?,
        description: product['description'] as String?,
        rating: product['rating'] as num?,
        brand: product['brand'] as String?,
        stock: product['stock'] as num?,
      )..thumbnailBlob = product['thumbnail_blob'] as Uint8List?;
    }).toList();
  }
}
