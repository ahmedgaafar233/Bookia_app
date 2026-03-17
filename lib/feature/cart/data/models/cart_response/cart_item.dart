class CartItem {
  int? itemId;
  int? itemProductId;
  String? itemProductName;
  String? itemProductImage;
  String? itemProductPrice;
  int? itemProductDiscount;
  String? itemProductPriceAfterDiscount;
  int? itemProductStock;
  int? itemQuantity;
  String? itemTotal;

  CartItem({
    this.itemId,
    this.itemProductId,
    this.itemProductName,
    this.itemProductImage,
    this.itemProductPrice,
    this.itemProductDiscount,
    this.itemProductPriceAfterDiscount,
    this.itemProductStock,
    this.itemQuantity,
    this.itemTotal,
  });

  CartItem.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    itemProductId = json['item_product_id'];
    itemProductName = json['item_product_name'];
    itemProductImage = json['item_product_image'];
    itemProductPrice = json['item_product_price'].toString();
    itemProductDiscount = json['item_product_discount'];
    itemProductPriceAfterDiscount =
        json['item_product_price_after_discount'].toString();
    itemProductStock = json['item_product_stock'];
    itemQuantity = json['item_quantity'];
    itemTotal = json['item_total'].toString();
  }

  Map<String, dynamic> toJson() => {
        'item_id': itemId,
        'item_product_id': itemProductId,
        'item_product_name': itemProductName,
        'item_product_image': itemProductImage,
        'item_product_price': itemProductPrice,
        'item_product_discount': itemProductDiscount,
        'item_product_price_after_discount': itemProductPriceAfterDiscount,
        'item_product_stock': itemProductStock,
        'item_quantity': itemQuantity,
        'item_total': itemTotal,
      };
}
