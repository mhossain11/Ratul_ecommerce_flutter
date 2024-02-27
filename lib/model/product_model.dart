/// uid : "184ed978-b850-4fc1-a49e-03180187592e"
/// name : "Novia"
/// description : "ghghjfjkfkjfkfhkfkfljgljgl"
/// product_image1 : null
/// stock : 5
/// price : "340.00"
/// discount : 10
/// over_discount : 5

class ProductModel {
  ProductModel({
      String? uid, 
      String? name, 
      String? description, 
      dynamic productImage1, 
      int? stock, 
      String? price, 
      int? discount, 
      int? overDiscount,}){
    _uid = uid;
    _name = name;
    _description = description;
    _productImage1 = productImage1;
    _stock = stock;
    _price = price;
    _discount = discount;
    _overDiscount = overDiscount;
}

  ProductModel.fromJson(dynamic json) {
    _uid = json['uid'];
    _name = json['name'];
    _description = json['description'];
    _productImage1 = json['product_image1'];
    _stock = json['stock'];
    _price = json['price'];
    _discount = json['discount'];
    _overDiscount = json['over_discount'];
  }
  String? _uid;
  String? _name;
  String? _description;
  dynamic _productImage1;
  int? _stock;
  String? _price;
  int? _discount;
  int? _overDiscount;

  String? get uid => _uid;
  String? get name => _name;
  String? get description => _description;
  dynamic get productImage1 => _productImage1;
  int? get stock => _stock;
  String? get price => _price;
  int? get discount => _discount;
  int? get overDiscount => _overDiscount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uid'] = _uid;
    map['name'] = _name;
    map['description'] = _description;
    map['product_image1'] = _productImage1;
    map['stock'] = _stock;
    map['price'] = _price;
    map['discount'] = _discount;
    map['over_discount'] = _overDiscount;
    return map;
  }

}