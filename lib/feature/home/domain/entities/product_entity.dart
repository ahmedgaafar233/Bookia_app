class ProductEntity {
  final int? id;
  final String? name;
  final String? description;
  final String? price;
  final String? discount;
  final String? priceAfterDiscount;
  final String? image;
  final int? categoryId;

  const ProductEntity({
    this.id,
    this.name,
    this.description,
    this.price,
    this.discount,
    this.priceAfterDiscount,
    this.image,
    this.categoryId,
  });
}

class SliderEntity {
  final int? id;
  final String? image;
  final String? title;

  const SliderEntity({this.id, this.image, this.title});
}
