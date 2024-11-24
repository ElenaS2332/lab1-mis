import 'dart:convert';

import 'package:flutter/services.dart';

import '../products/product.dart';

class ProductsService {
  Future<List<Product>> getAllProducts() async {
    final String response =
        await rootBundle.loadString('lib/data/clothes.json');
    final List<dynamic> data = jsonDecode(response);
    final products = data.map((json) => Product.fromJson(json)).toList();
    return products;
  }

  Future<Product?> getProduct(int id) async {
    final products = await getAllProducts();
    final produt = products.where((p) => p.id == id).firstOrNull;
    return produt;
  }
}
