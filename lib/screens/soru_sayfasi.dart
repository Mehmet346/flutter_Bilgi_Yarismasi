import 'package:flutter/material.dart';
import 'package:flutter_application_3/methods/firestore_methods.dart';
import 'package:flutter_application_3/utils/constants.dart';
import 'package:flutter_application_3/utils/test_veri.dart';
import 'package:google_fonts/google_fonts.dart';

class SoruSayfasi extends StatefulWidget {
  final String soruDerecesi;
  const SoruSayfasi({Key? key, required this.soruDerecesi}) : super(key: key);

  @override
  _SoruSayfasiState createState() => _SoruSayfasiState();
}

class _SoruSayfasiState extends State<SoruSayfasi> {
  List<Widget> secimler = [];
  TestVeri? testVeri_1;

  Future<void> sorulariCagir() async {
    List sorular = await FirestoreMethods().sorulariGetir(widget.soruDerecesi);
    testVeri_1 = TestVeri(sorular: sorular);
    setState(() {});
  }

  Future<void> sorulariKontrolEt(bool dogrumu) async {
    if (testVeri_1!.testBittimi()) {
      if (dogrumu == testVeri_1!.getSoruYaniti()) {
        secimler.add(dogruYanit);
        dogruYanitCount++;
      } else {
        secimler.add(yanlisYanit);
        yanlisYanitCount++;
      }
      setState(() {});
      await showMyDialog();
    } else {
      if (dogrumu == testVeri_1!.getSoruYaniti()) {
        secimler.add(dogruYanit);
        dogruYanitCount++;
      } else {
        secimler.add(yanlisYanit);
        yanlisYanitCount++;
      }
      testVeri_1!.sonrakiSoru();
      setState(() {});
    }
  }

//Sayfa açılınca ilk çalışacak fonksiyon initState
  @override
  void initState() {
    super.initState();

    //initState içerisinde setState yapmak için Future kullandık
    Future.delayed(Duration.zero, () async {
      await sorulariCagir();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('images/logo.png', height: 45),
        backgroundColor: const Color.fromARGB(255, 231, 160, 19),
      ),
      backgroundColor: const Color.fromARGB(255, 33, 120, 226),
      body: testVeri_1 == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        testVeri_1!.getSoruMetni(),
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
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Row(children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              primary: const Color.fromARGB(255, 253, 59, 55),
                            ),
                            child: const Icon(
                              Icons.thumb_down,
                              size: 30.0,
                            ),
                            onPressed: () async {
                              await sorulariKontrolEt(false);
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.all(12),
                              primary: const Color.fromARGB(255, 115, 207, 90),
                            ),
                            child: const Icon(Icons.thumb_up, size: 30.0),
                            onPressed: () async {
                              await sorulariKontrolEt(true);
                            },
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> showMyDialog() async {
    TextStyle style = const TextStyle(color: Colors.white);
    await showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: <Widget>[
              Text(
                'Tebrikler testi bitirdiniz',
                textAlign: TextAlign.left,
                style: style,
              ),
              Text(
                'Doğru Yanıt : $dogruYanitCount',
                style: style,
              ),
              Text(
                'Yanlış Yanıt : $yanlisYanitCount',
                style: style,
              ),
            ],
          ),
          backgroundColor: const Color.fromARGB(255, 6, 120, 135),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Başa dönmek için tıkla.',
                  style: style,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Başa dön.'),
              onPressed: () {
                setState(() {
                  testVeri_1!.testiSifirla();
                  secimler = [];
                  dogruYanitCount = 0;
                  yanlisYanitCount = 0;
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
