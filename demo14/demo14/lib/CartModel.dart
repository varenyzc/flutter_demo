import 'dart:collection';

import 'package:flutter/material.dart';

import 'Item.dart';

class CartModel extends ChangeNotifier{

  final List<Item> _items = [];

  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);
  
  double get totalPrice{
    return _items.fold(0, (value,item) => value+item.count*item.price);
  }

  void add(Item item) {
    _items.add(item);
    notifyListeners();
  }

  void remove(){
    _items.removeLast();
    notifyListeners();
  }
}