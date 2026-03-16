import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/item_provider.dart';
import '../widgets/dashboard_card.dart';
import 'item_list_screen.dart';

class DashboardScreen extends StatelessWidget{

  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context){

    final provider = Provider.of<ItemProvider>(context);

    return Scaffold(

      appBar: AppBar(title: const Text("Dashboard")),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            Row(
              children: [

                DashboardCard(
                  title:"ทั้งหมด",
                  value:provider.totalItems,
                  icon:Icons.inventory,
                  color:Colors.blue,
                ),

                DashboardCard(
                  title:"ใกล้หมดอายุ",
                  value:provider.nearExpiry,
                  icon:Icons.warning,
                  color:Colors.orange,
                ),

                DashboardCard(
                  title:"หมดอายุ",
                  value:provider.expired,
                  icon:Icons.error,
                  color:Colors.red,
                ),
              ],
            ),

            const SizedBox(height:30),

            ElevatedButton(
              child: const Text("ดูรายการสินค้า"),
              onPressed:(){

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:(_)=>const ItemListScreen(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}