import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/item_provider.dart';
import '../widgets/item_card.dart';
import 'add_edit_item_screen.dart';

class ItemListScreen extends StatefulWidget {

  const ItemListScreen({super.key});

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {

  String selectedCategory = "ทั้งหมด";

  @override
  void initState() {
    super.initState();

    Provider.of<ItemProvider>(
      context,
      listen: false
    ).fetchItems();
  }

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<ItemProvider>(context);

    return Scaffold(

      appBar: AppBar(
        title: const Text("รายการสินค้า"),
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddEditItemScreen(),
            ),
          );
        },
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            /// SEARCH
            TextField(
              decoration: const InputDecoration(
                labelText: "ค้นหาสินค้า",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {

                provider.searchItems(value);
              },
            ),

            const SizedBox(height:10),

            /// FILTER
            DropdownButton<String>(
              value: selectedCategory,
              isExpanded: true,
              items: const [

                DropdownMenuItem(
                  value: "ทั้งหมด",
                  child: Text("ทั้งหมด"),
                ),

                DropdownMenuItem(
                  value: "Food",
                  child: Text("อาหาร"),
                ),

                DropdownMenuItem(
                  value: "Drink",
                  child: Text("เครื่องดื่ม"),
                ),

                DropdownMenuItem(
                  value: "Fruit",
                  child: Text("ผลไม้"),
                ),

              ],

              onChanged: (value){

                setState(() {
                  selectedCategory = value!;
                });

                provider.filterCategory(value!);
              },
            ),

            const SizedBox(height:10),

            /// LIST
            Expanded(
              child: ListView.builder(

                itemCount: provider.items.length,

                itemBuilder: (context,index){

                  return ItemCard(
                    item: provider.items[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}