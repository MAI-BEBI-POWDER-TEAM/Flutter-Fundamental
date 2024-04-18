import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ExampleFormPageViews(),
    );
  }
}

// ======== Kalo mau buat Form, halaman harus StatefulWidget ========
class ExampleFormPageViews extends StatefulWidget {
  const ExampleFormPageViews({super.key});

  @override
  State<ExampleFormPageViews> createState() =>
      _ExampleFormPageViewsStatelessState();
}

class _ExampleFormPageViewsStatelessState extends State<ExampleFormPageViews> {
  // ======== Harus ada 1 formkey untuk 1 halaman berisi Form ========
  final _loginFormKey = GlobalKey<FormState>();

  // ======== 1 TextField / TextFormField harus punya 1 controller ========
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  // ====== 1 boolean untuk perubahan status login berhasil / gagal ========
  bool isLoginBerhasil = false;

  // ======== Karena ini TextField, validasi username manual ========
  usernameValidator(String? username) {
    if (username == null || username.isEmpty) {
      setState(() {
        isLoginBerhasil = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Username tidak boleh kosong!',
            style: TextStyle(fontSize: 20),
          ),
        ),
      );
    }

    return;
  }

  // ======== Karena ini TextField, validasi password manual ========
  passwordValidator(String? password) {
    if (password == null || password.isEmpty) {
      setState(() {
        isLoginBerhasil = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Password tidak boleh kosong!',
            style: TextStyle(fontSize: 20),
          ),
        ),
      );
    }

    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contoh Login Page'),
        backgroundColor: Colors.blueAccent.withOpacity(0.2),
      ),
      body: SafeArea(
        // ======== Padding biar bagus aja (optional) ========
        child: Padding(
          padding: const EdgeInsets.all(8),
          // ======== Harus ada ListView atau SingleChildScrollView, pilih aja ========
          // ======== Kalau mau bisa muat banyak widget, pilih ListView ========
          // ======== Kalau cuma mau 1 widget, pilih SingleChildScrollView ========
          child: ListView(
            children: [
              SizedBox(
                height: 240,
                // ======== Card biar bagus aja (optional) ========
                child: Card(
                  elevation: 0.5,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      // ======== formkey dipanggil di Form ========
                      key: _loginFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextField(
                            controller: _usernameController,
                            keyboardType: TextInputType.text,
                            // ======== Semua decoration optional ========
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              hintText: 'Type username...',
                              labelText: 'Username',
                            ),
                          ),
                          TextField(
                            controller: _passwordController,
                            // ======== Password bisa di-hide ========
                            obscureText: true,
                            keyboardType: TextInputType.text,
                            // ======== Semua decoration optional ========
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              hintText: 'Type password...',
                              labelText: 'Passowrd',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
                child: ElevatedButton(
                  onPressed: () {
                    // ====== Cek dengan semua validasi ========
                    usernameValidator(_usernameController.text);
                    passwordValidator(_passwordController.text);

                    if (_usernameController.text == 'Vina' &&
                        _passwordController.text == '6701223126') {
                      // ====== Kalau berhasil, berikan message ========
                      setState(() {
                        isLoginBerhasil = true;
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Login Berhasil! Mohon Scroll Bawah',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      );
                    } else {
                      setState(() {
                        isLoginBerhasil = false;
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Login Gagal, username & password salah!',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(
                      MediaQuery.of(context).size.width,
                      60,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Center(
                child: Visibility(
                  visible: isLoginBerhasil,
                  child: Image.asset('assets/surprise.jpg'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
