import 'package:flutter/material.dart';
import '../models/item.dart';

class ItemDetailScreen extends StatelessWidget {

  final Item item;

  const ItemDetailScreen({
    super.key,
    required this.item
  });

  @override
  Widget build(BuildContext context){

    return Scaffold(

      appBar: AppBar(
        title: const Text("รายละเอียดสินค้า"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text(
              "ชื่อสินค้า: ${item.name}",
              style: const TextStyle(
                fontSize:20,
                fontWeight:FontWeight.bold
              ),
            ),

            const SizedBox(height:10),

            Text(
              "ประเภท: ${item.category}",
              style: const TextStyle(fontSize:18),
            ),

            const SizedBox(height:10),

            Text(
              "จำนวน: ${item.quantity}",
              style: const TextStyle(fontSize:18),
            ),

            const SizedBox(height:10),

            Text(
              "วันหมดอายุ: ${item.expiryDate.substring(0,10)}",
              style: const TextStyle(fontSize:18),
            ),
          ],
        ),
      ),
    );
  }
}