import 'dart:convert';
import 'dart:typed_data';

RespProducts respProductsFromJson(String str) => RespProducts.fromJson(json.decode(str));
String respProductsToJson(RespProducts data) => json.encode(data.toJson());
class RespProducts {
  RespProducts({
      this.products, 
      this.total, 
      this.skip, 
      this.limit,});

  RespProducts.fromJson(dynamic json) {
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(Products.fromJson(v));
      });
    }
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }
  List<Products>? products;
  num? total;
  num? skip;
  num? limit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    map['total'] = total;
    map['skip'] = skip;
    map['limit'] = limit;
    return map;
  }

}

Products productsFromJson(String str) => Products.fromJson(json.decode(str));
String productsToJson(Products data) => json.encode(data.toJson());
class Products {
  Products({
      this.id, 
      this.title, 
      this.description, 
      this.category, 
      this.price, 
      this.discountPercentage, 
      this.rating, 
      this.stock, 
      this.tags, 
      this.brand, 
      this.sku, 
      this.weight, 
      this.dimensions, 
      this.warrantyInformation, 
      this.shippingInformation, 
      this.availabilityStatus, 
      this.reviews, 
      this.returnPolicy, 
      this.minimumOrderQuantity, 
      this.meta, 
      this.images, 
      this.thumbnail,});

  Products.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    category = json['category'];
    price = json['price'];
    discountPercentage = json['discountPercentage'];
    rating = json['rating'];
    stock = json['stock'];
    tags = json['tags'] != null ? json['tags'].cast<String>() : [];
    brand = json['brand'];
    sku = json['sku'];
    weight = json['weight'];
    dimensions = json['dimensions'] != null ? Dimensions.fromJson(json['dimensions']) : null;
    warrantyInformation = json['warrantyInformation'];
    shippingInformation = json['shippingInformation'];
    availabilityStatus = json['availabilityStatus'];
    if (json['reviews'] != null) {
      reviews = [];
      json['reviews'].forEach((v) {
        reviews?.add(Reviews.fromJson(v));
      });
    }
    returnPolicy = json['returnPolicy'];
    minimumOrderQuantity = json['minimumOrderQuantity'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    images = json['images'] != null ? json['images'].cast<String>() : [];
    thumbnail = json['thumbnail'];
    thumbnailBlob = json['thumbnailBlob']; // Add this if you want to support it in JSON
  }
  num? id;
  String? title;
  String? description;
  String? category;
  num? price;
  num? discountPercentage;
  num? rating;
  num? stock;
  List<String>? tags;
  String? brand;
  String? sku;
  num? weight;
  Dimensions? dimensions;
  String? warrantyInformation;
  String? shippingInformation;
  String? availabilityStatus;
  List<Reviews>? reviews;
  String? returnPolicy;
  num? minimumOrderQuantity;
  Meta? meta;
  List<String>? images;
  String? thumbnail;
  Uint8List? thumbnailBlob;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['category'] = category;
    map['price'] = price;
    map['discountPercentage'] = discountPercentage;
    map['rating'] = rating;
    map['stock'] = stock;
    map['tags'] = tags;
    map['brand'] = brand;
    map['sku'] = sku;
    map['weight'] = weight;
    if (dimensions != null) {
      map['dimensions'] = dimensions?.toJson();
    }
    map['warrantyInformation'] = warrantyInformation;
    map['shippingInformation'] = shippingInformation;
    map['availabilityStatus'] = availabilityStatus;
    if (reviews != null) {
      map['reviews'] = reviews?.map((v) => v.toJson()).toList();
    }
    map['returnPolicy'] = returnPolicy;
    map['minimumOrderQuantity'] = minimumOrderQuantity;
    if (meta != null) {
      map['meta'] = meta?.toJson();
    }
    map['images'] = images;
    map['thumbnail'] = thumbnail;
    // Note: thumbnailBlob is usually not sent back to JSON as bytes
    return map;
  }

}

Meta metaFromJson(String str) => Meta.fromJson(json.decode(str));
String metaToJson(Meta data) => json.encode(data.toJson());
class Meta {
  Meta({
      this.createdAt, 
      this.updatedAt, 
      this.barcode, 
      this.qrCode,});

  Meta.fromJson(dynamic json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    barcode = json['barcode'];
    qrCode = json['qrCode'];
  }
  String? createdAt;
  String? updatedAt;
  String? barcode;
  String? qrCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['barcode'] = barcode;
    map['qrCode'] = qrCode;
    return map;
  }

}

Reviews reviewsFromJson(String str) => Reviews.fromJson(json.decode(str));
String reviewsToJson(Reviews data) => json.encode(data.toJson());
class Reviews {
  Reviews({
      this.rating, 
      this.comment, 
      this.date, 
      this.reviewerName, 
      this.reviewerEmail,});

  Reviews.fromJson(dynamic json) {
    rating = json['rating'];
    comment = json['comment'];
    date = json['date'];
    reviewerName = json['reviewerName'];
    reviewerEmail = json['reviewerEmail'];
  }
  num? rating;
  String? comment;
  String? date;
  String? reviewerName;
  String? reviewerEmail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rating'] = rating;
    map['comment'] = comment;
    map['date'] = date;
    map['reviewerName'] = reviewerName;
    map['reviewerEmail'] = reviewerEmail;
    return map;
  }

}

Dimensions dimensionsFromJson(String str) => Dimensions.fromJson(json.decode(str));
String dimensionsToJson(Dimensions data) => json.encode(data.toJson());
class Dimensions {
  Dimensions({
      this.width, 
      this.height, 
      this.depth,});

  Dimensions.fromJson(dynamic json) {
    width = json['width'];
    height = json['height'];
    depth = json['depth'];
  }
  num? width;
  num? height;
  num? depth;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['width'] = width;
    map['height'] = height;
    map['depth'] = depth;
    return map;
  }

}