class Food {
  final int id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String typeFood;
  final String time;
  // String shortDescription;
  // String timeDelivery;
  

  Food({
    required this.id,
    required this.name, 
    required this.description, 
    required this.price, 
    required this.imageUrl, 
    required this.typeFood,
    required this.time,
    // this.shortDescription = "Con ingredientes frescos",
    // this.timeDelivery = "10 min",
  });
}