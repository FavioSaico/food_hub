class Product {
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String typeFood;
  String shortDescription;
  String time;
  String timeDelivery;
  

  Product({
    required this.name, 
    required this.description, 
    required this.price, 
    required this.imageUrl, 
    required this.typeFood,
    this.shortDescription = "Con ingredientes frescos",
    this.time = "20 min",
    this.timeDelivery = "10 min",
  });
}