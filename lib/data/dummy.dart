import 'package:flutter/material.dart';

class Dummy {
  static const List<String> shopCategoryTitle = [
    "Gadgets and Computers",
    "Fashion",
    "Beauty and Health",
    "Babies and Kids",
    "Home and Garden",
    "Sports and Hobby",
    "Ticket and Voucher",
    "Service and Food"
  ];
  static const List<String> shopCategoryBrief = [
    "100k Items",
    "655k Items",
    "221k Items",
    "85k Items",
    "725k Items",
    "932k Items",
    "475k Items",
    "362k Items"
  ];
  static const List<String> shopCategoryImg = [
    "image.jpg",
    "image.jpg",
    "image.jpg",
    "image.jpg",
    "image.jpg",
    "image.jpg",
    "image.jpg",
    "image.jpg",
  ];

  static const List<IconData> shopCategoryIcon = [
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
    for (int i = 0; i < shopCategoryTitle.length; i++) {
      ShopCategory obj = ShopCategory();
      obj.icon = shopCategoryIcon[i];
      obj.image = shopCategoryImg[i];
      obj.title = shopCategoryTitle[i];
      obj.brief = shopCategoryBrief[i];
      items.add(obj);
    }
    return items;
  }
}

class ShopCategory {
  IconData? icon;
  late String image;
  late String title;
  late String brief;
}
