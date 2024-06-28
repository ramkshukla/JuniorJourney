// ignore_for_file: constant_identifier_names

import 'package:junior_journey/model/category.dart';
import 'package:flutter/material.dart';

class Dummy {
  static const List<String> shop_category_title = [
    "Gadgets and Computers",
    "Fashion",
    "Beauty and Health",
    "Babies and Kids",
    "Home and Garden",
    "Sports and Hobby",
    "Ticket and Voucher",
    "Service and Food"
  ];
  static const List<String> shop_category_brief = [
    "100k Items",
    "655k Items",
    "221k Items",
    "85k Items",
    "725k Items",
    "932k Items",
    "475k Items",
    "362k Items"
  ];
  static const List<String> shop_category_img = [
    "image.jpg",
    "image.jpg",
    "image.jpg",
    "image.jpg",
    "image.jpg",
    "image.jpg",
    "image.jpg",
    "image.jpg",
  ];

  static const List<IconData> shop_category_icon = [
    Icons.devices,
    Icons.accessibility,
    Icons.face,
    Icons.child_friendly,
    Icons.weekend,
    Icons.pool,
    Icons.confirmation_number,
    Icons.restaurant
  ];
  static List<ShopCategory> getShoppingCategory() {
    List<ShopCategory> items = [];
    for (int i = 0; i < shop_category_title.length; i++) {
      ShopCategory obj = ShopCategory();
      obj.icon = shop_category_icon[i];
      obj.image = shop_category_img[i];
      obj.title = shop_category_title[i];
      obj.brief = shop_category_brief[i];
      items.add(obj);
    }
    return items;
  }
}
