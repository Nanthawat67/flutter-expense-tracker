import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/item.dart';
import '../providers/item_provider.dart';
import '../screens/add_edit_item_screen.dart';
import '../screens/item_detail_screen.dart';

class ItemCard extends StatelessWidget {

  final Item item;

  const ItemCard({super.key, required this.item});

  IconData getIcon(String category) {

    switch (category) {
      case "Food":
        return Icons.fastfood;
      case "Drink":
        return Icons.local_drink;
      case "Fruit":
        return Icons.apple;
      default:
        return Icons.inventory;
    }
  }

  @override
  Widget build(BuildContext context) {

    DateTime expiry = DateTime.parse(item.expiryDate);
    DateTime today = DateTime.now();

    Color color = Colors.green;

    if (expiry.isBefore(today)) {
      color = Colors.red;
    } else if (expiry.difference(today).inDays <= 3) {
      color = Colors.orange;
    }

    return Card(
      child: ListTile(

        leading: Icon(
          getIcon(item.category),
          color: color,
        ),

        title: Text(
          item.name,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Text(
          "จำนวน ${item.quantity} | หมดอายุ ${item.expiryDate.substring(0,10)}",
        ),

        /// กดดูรายละเอียด
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ItemDetailScreen(item: item),
            ),
          );
        },

        /// ปุ่มแก้ไข + ลบ
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            /// ปุ่มแก้ไข
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddEditItemScreen(item: item),
                  ),
                );

              },
            ),

            /// ปุ่มลบ
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {

                showDialog(
                  context: context,
                  builder: (context) {

                    return AlertDialog(

                      title: const Text("ยืนยันการลบ"),

                      content: Text(
                        "ต้องการลบ ${item.name} หรือไม่"
                      ),

                      actions: [

                        TextButton(
                          child: const Text("ยกเลิก"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),

                        ElevatedButton(
                          child: const Text("ลบ"),
                          onPressed: () {

                            Provider.of<ItemProvider>(
                              context,
                              listen: false
                            ).deleteItem(item.id!);

                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );

              },
            ),

          ],
        ),
      ),
    );
  }
}