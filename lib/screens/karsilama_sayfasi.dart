import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class KarsilamaSayfasi extends StatefulWidget {
  const KarsilamaSayfasi({Key? key}) : super(key: key);

  @override
  State<KarsilamaSayfasi> createState() => _KarsilamaSayfasiState();
}

class _KarsilamaSayfasiState extends State<KarsilamaSayfasi> {
  @override
  Widget build(BuildContext context) {
    Size mainSize = MediaQuery.of(context).size;
    Size minimumSize = Size(mainSize.width / 1.2, 50);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Bir zorluk seviyesi seç!',
            textAlign: TextAlign.center,
            style: GoogleFonts.comicNeue(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: mainSize.width / 4, vertical: 20),
            child: const Divider(
              thickness: 2,
              color: Colors.orange,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.toNamed('/kolay');
            },
            child: Text(
              'Kolay',
              style: GoogleFonts.comicNeue(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: minimumSize,
              primary: Colors.green,
              shape: const StadiumBorder(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              Get.toNamed('/orta');
            },
            child: Text(
              'Orta',
              style: GoogleFonts.comicNeue(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: minimumSize,
              primary: Colors.orange.shade700,
              shape: const StadiumBorder(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              Get.toNamed('/zor');
            },
            child: Text(
              'Zor',
              style: GoogleFonts.comicNeue(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: minimumSize,
              primary: Colors.red.shade700,
              shape: const StadiumBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
