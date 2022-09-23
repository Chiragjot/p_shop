import 'dart:convert';

import 'package:flutter/services.dart';

Future fetchProducts() async {
  var products = await rootBundle.loadString('assets/products.json');
  return products;
}

Future<int> getSize() async {
  var products = await rootBundle.loadString('assets/products.json');
  List length = jsonDecode(products.toString());
  print('mmmmmmmmmmmm' + length.length.toString());
  return length.length;
}
