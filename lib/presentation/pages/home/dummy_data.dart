class Category {
  final String name;
  final String image;

  Category({required this.name, required this.image});
}

final List<Category> categories = [
  Category(name: 'Салаты', image: 'assets/temp/salad.png'),
  Category(name: 'Пицца', image: 'assets/temp/pizza.png'),
  Category(name: 'Супы', image: 'assets/temp/soup.png'),
];

class Food {
  final String name;
  final String image;
  final String description;
  final double price;
  final double rating;

  Food({
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.rating,
  });
}

final List<Food> popularFoods = [
  Food(
    name: 'Босо Лагман',
    image: 'assets/temp/lagman.png',
    description:
        'Во многих источниках история происхождения лагмана уходит своими корнями в древний Китай.',
    price: 320,
    rating: 4.6,
  ),
];
