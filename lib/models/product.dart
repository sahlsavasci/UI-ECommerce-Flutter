class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final int discountPercent;
  final String imagePath;
  final String category;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    this.discountPercent = 0,
    required this.imagePath,
    this.category = 'General',
  });

  double get discountedPrice {
    if (discountPercent <= 0) return price;
    return price * (1 - (discountPercent / 100));
  }
}
