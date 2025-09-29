import 'package:flutter/material.dart';
import '../data/food_data.dart'; // <-- 1. Impor file data
import 'order_page.dart';

// Hapus class FoodItem yang lama karena sudah digantikan oleh FoodMenu

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 2. Tidak perlu lagi mendefinisikan list di sini
    // final List<FoodItem> menuItems = [...];

    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Menu')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(
                'assets/banner.png',
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio:
                    0.7, // Sedikit diubah agar ada ruang untuk tombol
              ),
              // 3. Gunakan list dari file data
              itemCount: foodMenuList.length,
              itemBuilder: (context, index) {
                // 4. Ambil data dari foodMenuList
                final FoodMenu item = foodMenuList[index];
                return _buildMenuCard(context, item);
              },
            ),
          ),
        ],
      ),
    );
  }

  // 5. Ubah parameter dari FoodItem menjadi FoodMenu
  Widget _buildMenuCard(BuildContext context, FoodMenu item) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        // onTap tetap ada agar seluruh kartu bisa diklik
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OrderPage(item: item)),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.asset(
                item.imageUrl, // <-- Gunakan imageUrl
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.fastfood,
                    size: 60,
                    color: Colors.grey,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // Menampilkan kategori pertama
                  Text(
                    item.categories.first,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  const SizedBox(height: 8),

                  // --- PERUBAHAN DIMULAI DI SINI ---
                  Row(
                    children: [
                      // Harga dibungkus Expanded agar mendorong tombol ke kanan
                      Expanded(
                        child: Text(
                          'Rp ${item.price}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Tombol Pesan
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderPage(item: item),
                            ),
                          );
                        },
                        // Styling agar tombol tidak terlalu besar
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          'Pesan',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  // --- AKHIR PERUBAHAN ---
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
