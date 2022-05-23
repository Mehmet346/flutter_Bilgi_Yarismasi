import 'package:flutter/material.dart';
import 'package:flutter_application_3/soru.dart';
import 'package:flutter_application_3/test_veri.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

void main() => runApp(BilgiTesti());

class BilgiTesti extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset('images/logo.png', height: 45),
          backgroundColor: Color.fromARGB(255, 231, 160, 19),
        ),
        backgroundColor: Color.fromARGB(255, 33, 120, 226),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: SoruSayfasi(),
          ),
        ),
      ),
    );
  }
}

class SoruSayfasi extends StatefulWidget {
  @override
  _SoruSayfasiState createState() => _SoruSayfasiState();
}

class _SoruSayfasiState extends State<SoruSayfasi> {
  List<Widget> secimler = [];

  TestVeri testVeri_1 = TestVeri();

  SorulariKontrolEt(bool dogrumu) {
    if (testVeri_1.testBittimi()) {
      showMyDialog();
    } else {
      setState(() {
        if (dogrumu == testVeri_1.getSoruYaniti()) {
          secimler.add(DogruYanit);
          DogruYanitCount++;
        } else {
          secimler.add(YanlisYanit);
          YanlisYanitCount++;
        }
        testVeri_1.sonrakiSoru();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                testVeri_1.getSoruMetni(),
                textAlign: TextAlign.center,
                style: GoogleFonts.ebGaramond(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Wrap(
          spacing: 3,
          runSpacing: 3,
          direction: Axis.horizontal,
          children: secimler,
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.0),
            child: Row(children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: RaisedButton(
                    padding: EdgeInsets.all(12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textColor: Colors.white,
                    color: Color.fromARGB(255, 253, 59, 55),
                    child: Icon(
                      Icons.thumb_down,
                      size: 30.0,
                    ),
                    onPressed: () {
                      SorulariKontrolEt(false);
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.all(12),
                    textColor: Colors.white,
                    color: Color.fromARGB(255, 115, 207, 90),
                    child: Icon(Icons.thumb_up, size: 30.0),
                    onPressed: () {
                      SorulariKontrolEt(true);
                    },
                  ),
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }

  showMyDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: <Widget>[
              Text(
                'Tebrikler testi bitirdiniz',
                textAlign: TextAlign.left,
              ),
              Text(
                'Doğru Yanıt : $DogruYanitCount',
              ),
              Text(
                'Yanlış Yanıt : $YanlisYanitCount',
              ),
            ],
          ),
          backgroundColor: Color.fromARGB(255, 6, 120, 135),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Başa dönmek için tıkla.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Başa dön.'),
              onPressed: () {
                setState(() {
                  testVeri_1.testiSifirla();
                  secimler = [];
                  DogruYanitCount = 0;
                  YanlisYanitCount = 0;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
