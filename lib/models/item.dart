class Item {

  int? id;
  String name;
  String category;
  int quantity;
  String expiryDate;

  Item({
    this.id,
    required this.name,
    required this.category,
    required this.quantity,
    required this.expiryDate,
  });

  Map<String, dynamic> toMap(){

    return{
      'id': id,
      'name': name,
      'category': category,
      'quantity': quantity,
      'expiryDate': expiryDate
    };
  }

  factory Item.fromMap(Map<String,dynamic> map){

    return Item(
      id: map['id'],
      name: map['name'],
      category: map['category'],
      quantity: map['quantity'],
      expiryDate: map['expiryDate'],
    );
  }
}