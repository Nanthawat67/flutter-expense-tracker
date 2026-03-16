import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/item.dart';
import '../providers/item_provider.dart';

class AddEditItemScreen extends StatefulWidget {

  final Item? item;

  const AddEditItemScreen({super.key, this.item});

  @override
  State<AddEditItemScreen> createState() => _AddEditItemScreenState();
}

class _AddEditItemScreenState extends State<AddEditItemScreen> {

  final _formKey = GlobalKey<FormState>();

  String name = "";
  String category = "Food";
  int quantity = 1;
  DateTime expiry = DateTime.now();

  @override
  void initState() {
    super.initState();

    if (widget.item != null) {

      name = widget.item!.name;
      category = widget.item!.category;
      quantity = widget.item!.quantity;
      expiry = DateTime.parse(widget.item!.expiryDate);

    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text(
          widget.item == null
              ? "เพิ่มสินค้า"
              : "แก้ไขสินค้า",
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Form(
          key: _formKey,

          child: Column(
            children: [

              /// ชื่อสินค้า
              TextFormField(
                initialValue: name,
                decoration: const InputDecoration(
                  labelText: "ชื่อสินค้า",
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "กรุณากรอกชื่อสินค้า";
                  }
                  return null;
                },

                onSaved: (value) {
                  name = value!;
                },
              ),

              const SizedBox(height: 10),

              /// หมวดหมู่
              DropdownButtonFormField(

                value: category,

                items: const [

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

                onChanged: (value) {
                  category = value!;
                },
              ),

              const SizedBox(height: 10),

              /// จำนวน
              TextFormField(

                initialValue: quantity.toString(),

                decoration: const InputDecoration(
                  labelText: "จำนวน",
                ),

                keyboardType: TextInputType.number,

                onSaved: (value) {
                  quantity = int.parse(value!);
                },
              ),

              const SizedBox(height: 15),

              /// เลือกวันหมดอายุ
              ElevatedButton(

                child: const Text("เลือกวันหมดอายุ"),

                onPressed: () async {

                  final date = await showDatePicker(
                    context: context,
                    initialDate: expiry,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );

                  if (date != null) {
                    setState(() {
                      expiry = date;
                    });
                  }

                },
              ),

              const SizedBox(height: 20),

              /// ปุ่มบันทึก
              ElevatedButton(

                child: const Text("บันทึก"),

                onPressed: () {

                  if (_formKey.currentState!.validate()) {

                    _formKey.currentState!.save();

                    Item newItem = Item(
                      name: name,
                      category: category,
                      quantity: quantity,
                      expiryDate: expiry.toString(),
                    );

                    if (widget.item == null) {

                      /// เพิ่มสินค้า
                      Provider.of<ItemProvider>(
                        context,
                        listen: false,
                      ).addItem(newItem);

                    } else {

                      /// แก้ไขสินค้า
                      newItem.id = widget.item!.id;

                      Provider.of<ItemProvider>(
                        context,
                        listen: false,
                      ).updateItem(newItem);
                    }

                    Navigator.pop(context);

                  }

                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}