import 'package:flutter/material.dart';
import '../data/food_data.dart';
import 'login_page.dart'; // Impor LoginPage untuk navigasi logout
import 'order_page.dart';

class HomePage extends StatelessWidget {
  // Terima data username dari halaman login
  final String username;

  const HomePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Tampilkan username di title
        title: Text('Selamat Datang, $username!'),
        centerTitle: false, // Membuat judul rata kiri
        actions: [
          // Tambahkan tombol Logout
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              // Navigasi kembali ke LoginPage dan hapus semua halaman sebelumnya
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Banner
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(
                'assets/banner.png', // Sesuaikan nama banner jika berbeda
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Grid menu
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.75, // Disesuaikan untuk layout baru
              ),
              itemCount: foodMenuList.length,
              itemBuilder: (context, index) {
                final FoodMenu item = foodMenuList[index];
                return _buildMenuCard(context, item);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildMenuCard dengan UI yang dimodifikasi
  Widget _buildMenuCard(BuildContext context, FoodMenu item) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: InkWell(
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
                item.imageUrl,
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
                  Text(
                    item.categories.first,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  const SizedBox(height: 8),

                  // --- UI BARU UNTUK HARGA DAN TOMBOL ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Harga
                      Text(
                        'Rp ${item.price}',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
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
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          'Pesan',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  // --- AKHIR DARI UI BARU ---
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
