import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/methods/auth_methods.dart';
import 'package:get/get.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  State<AdminLogin> createState() => AdminLoginState();
}

class AdminLoginState extends State<AdminLogin> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (FirebaseAuth.instance.currentUser != null) {
        Get.offNamedUntil('/admin', (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    InputDecoration inputDec(String label) => InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        );

    return Form(
      key: _formKey,
      child: Material(
        elevation: 20,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  validator: (e) {
                    if (e!.isEmpty) {
                      return 'Bu alan boş bırakılamaz!';
                    } else if (!GetUtils.isEmail(e)) {
                      return 'Lütfen geçerli bir e-posta girin';
                    }
                    return null;
                  },
                  decoration: inputDec('E-Posta'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  validator: (e) {
                    if (e!.isEmpty) {
                      return 'Bu alan boş bırakılamaz!';
                    }
                    return null;
                  },
                  decoration: inputDec('Parola'),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String res = await AuthMethods().login(
                          _emailController.text, _passwordController.text);

                      if (res != 'success') {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(res)));
                      } else {
                        Get.offNamedUntil('/admin', (route) => false);
                      }
                    }
                  },
                  child: const Text('Giriş Yap'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
