import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/adminPanel/admin.dart';
import 'package:flutter_application_3/adminPanel/login_page.dart';
import 'package:flutter_application_3/screens/karsilama_sayfasi.dart';
import 'package:flutter_application_3/screens/soru_sayfasi.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_utils/src/platform/platform.dart';

void main() async {
  //Firebase bağlantı
  WidgetsFlutterBinding.ensureInitialized();
  if (GetPlatform.isWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyDxs8oZfrLjgp9csdDbg7GxZpq20w4010c",
      authDomain: "flutterapplication-906c1.firebaseapp.com",
      projectId: "flutterapplication-906c1",
      storageBucket: "flutterapplication-906c1.appspot.com",
      messagingSenderId: "970540202882",
      appId: "1:970540202882:web:f3b94dfcdb0ac128af6d9b",
      measurementId: "G-M5874TBSYC",
    ));
  } else {
    await Firebase.initializeApp();
  }
  ////////////
  runApp(const BilgiTesti());
}

class BilgiTesti extends StatelessWidget {
  const BilgiTesti({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: GetPlatform.isMobile ? '/' : '/login',
      //Route sistemi
      getPages: [
        GetPage(name: '/', page: () => const KarsilamaSayfasi()),
        GetPage(name: '/admin', page: () => const AdminPanel()),
        GetPage(name: '/login', page: () => const AdminLogin()),
        GetPage(
            name: '/kolay',
            page: () => const SoruSayfasi(
                  soruDerecesi: 'kolay',
                )),
        GetPage(
            name: '/orta',
            page: () => const SoruSayfasi(
                  soruDerecesi: 'orta',
                )),
        GetPage(
            name: '/zor',
            page: () => const SoruSayfasi(
                  soruDerecesi: 'zor',
                )),
      ],
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset('images/logo.png', height: 45),
          backgroundColor: const Color.fromARGB(255, 231, 160, 19),
        ),
        backgroundColor: const Color.fromARGB(255, 33, 120, 226),
        body: const SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: KarsilamaSayfasi()),
        ),
      ),
    );
  }
}
