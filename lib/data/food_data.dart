class FoodMenu {
  String name;
  int price;
  String imageUrl;
  String description;
  List<String> categories;

  FoodMenu({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.categories,
  });
}

// Ini adalah list data utama kita, mirip seperti gameList
var foodMenuList = [
  FoodMenu(
    name: 'Nasi Goreng',
    price: 15000,
    imageUrl: 'assets/nasi_goreng.png',
    description:
        'Nasi goreng spesial dengan campuran telur, ayam suwir, dan sayuran segar. Disajikan hangat dengan kerupuk.',
    categories: ['Makanan Utama', 'Populer', 'Nasi'],
  ),
  FoodMenu(
    name: 'Mie Ayam',
    price: 12000,
    imageUrl: 'assets/mie_ayam.png',
    description:
        'Mie kenyal dengan topping ayam kecap, sawi hijau, dan pangsit goreng. Dilengkapi dengan kuah kaldu gurih.',
    categories: ['Makanan Utama', 'Populer', 'Mie'],
  ),
  FoodMenu(
    name: 'Sate Ayam',
    price: 18000,
    imageUrl: 'assets/sate_ayam.png',
    description:
        '10 tusuk sate ayam yang dibakar sempurna dan dilumuri bumbu kacang khas. Disajikan dengan lontong dan irisan bawang merah.',
    categories: ['Lauk', 'Populer', 'Daging'],
  ),
  FoodMenu(
    name: 'Bakso',
    price: 13000,
    imageUrl: 'assets/bakso.png',
    description:
        'Semangkuk bakso sapi dengan mie, bihun, tahu, dan sawi. Disiram dengan kuah kaldu sapi yang kaya rasa.',
    categories: ['Makanan Kuah', 'Populer', 'Daging'],
  ),
];
