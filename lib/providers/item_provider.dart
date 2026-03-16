import 'package:flutter/material.dart';
import '../models/item.dart';
import '../services/database_helper.dart';

class ItemProvider with ChangeNotifier{

  List<Item> _items = [];
  List<Item> _filtered = [];

  String _search = "";
  String _category = "ทั้งหมด";

  List<Item> get items => _filtered;

  Future fetchItems() async{

    _items = await DatabaseHelper.instance.getItems();
    applyFilters();
  }

  void applyFilters(){

    _filtered = _items.where((item){

      final matchSearch =
          item.name.toLowerCase().contains(_search);

      final matchCategory =
          _category == "ทั้งหมด" ||
          item.category == _category;

      return matchSearch && matchCategory;

    }).toList();

    notifyListeners();
  }

  void searchItems(String keyword){

    _search = keyword.toLowerCase();
    applyFilters();
  }

  void filterCategory(String category){

    _category = category;
    applyFilters();
  }

  Future addItem(Item item) async{

    await DatabaseHelper.instance.insertItem(item);
    await fetchItems();
  }

  Future updateItem(Item item) async{

    await DatabaseHelper.instance.updateItem(item);
    await fetchItems();
  }

  Future deleteItem(int id) async{

    await DatabaseHelper.instance.deleteItem(id);
    await fetchItems();
  }

  int get totalItems => _items.length;

  int get expired{

    final today = DateTime.now();

    return _items.where(
      (item)=>DateTime.parse(item.expiryDate).isBefore(today)
    ).length;
  }

  int get nearExpiry{

    final today = DateTime.now();

    return _items.where((item){

      final diff = DateTime.parse(item.expiryDate)
          .difference(today).inDays;

      return diff <=3 && diff>=0;

    }).length;
  }
}