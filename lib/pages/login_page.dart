import 'package:flutter/material.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Key tidak lagi diperlukan
  // final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final Map<String, String> userData = {'fulan': 'fulan', 'Zakinanda': '12345'};

  // --- TAMBAHAN: State untuk visibilitas password ---
  bool _isPasswordVisible = false;
  // --------------------------------------------------

  bool checkLogin(String username, String password) {
    return userData.containsKey(username) && userData[username] == password;
  }

  void _login() {
    bool isLoginIn = checkLogin(
      _usernameController.text,
      _passwordController.text,
    );

    if (isLoginIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(username: _usernameController.text),
        ),
      );
    } else {
      // Menampilkan SnackBar jika login gagal (tanpa GlobalKey)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username atau Password salah!'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ScaffoldMessenger wrapper tidak lagi diperlukan
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.fastfood,
                size: 100,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 24),
              Text(
                'Selamat Datang di FoodApp',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Silakan login untuk melanjutkan',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 48),
              // TextField untuk Username (tidak berubah)
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              // --- PERUBAHAN: TextField untuk Password ---
              TextField(
                controller: _passwordController,
                obscureText:
                    !_isPasswordVisible, // Teks disembunyikan berdasarkan state
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  // Menambahkan ikon di akhir field
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Mengubah ikon berdasarkan state
                      _isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      // Mengubah state saat ikon di-klik
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              // ------------------------------------------
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _login,
                  child: const Text('Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
