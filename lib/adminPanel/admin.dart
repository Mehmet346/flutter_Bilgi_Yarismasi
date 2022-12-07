import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/methods/firestore_methods.dart';
import 'package:get/get.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({Key? key}) : super(key: key);

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  Stream<QuerySnapshot> sorulariDinle() async* {
    yield* FirebaseFirestore.instance.collection('sorular').snapshots();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await Future.delayed(const Duration(seconds: 1));
      if (FirebaseAuth.instance.currentUser == null) {
        Get.offNamedUntil('/login', (route) => false);
      } else {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirebaseAuth.instance.currentUser == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : StreamBuilder(
              stream: sorulariDinle(),
              builder: (context, AsyncSnapshot snap) {
                if (snap.hasError) {
                  return const Text('Hata');
                }

                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snap.hasData) {
                  var docs = snap.data.docs;
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 3,
                        vertical: 30,
                      ),
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              bool _isLoading = false;
                              var soruController = TextEditingController();
                              bool _yanitValue = false;
                              String _zorlukValue = 'kolay';
                              await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return StatefulBuilder(builder:
                                        (context, StateSetter setState) {
                                      return AlertDialog(
                                        title: const Text('Soru Ekle'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextField(
                                              controller: soruController,
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Soru',
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Checkbox(
                                                  value: _yanitValue,
                                                  onChanged: (e) {
                                                    setState(() {
                                                      _yanitValue = e!;
                                                    });
                                                  },
                                                ),
                                                const Text('Cevap doğru mu?'),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            DropdownButton<String>(
                                              value: _zorlukValue,
                                              icon: const Icon(
                                                  Icons.arrow_downward),
                                              elevation: 16,
                                              underline: Container(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  _zorlukValue = newValue!;
                                                });
                                              },
                                              items: <String>[
                                                'kolay',
                                                'orta',
                                                'zor'
                                              ].map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: _isLoading
                                                ? null
                                                : () => Navigator.pop(context),
                                            child: const Text('Vazgeç'),
                                          ),
                                          ElevatedButton(
                                            onPressed: _isLoading
                                                ? null
                                                : () async {
                                                    setState(() =>
                                                        _isLoading = true);
                                                    String res =
                                                        await FirestoreMethods()
                                                            .soruEkle(
                                                      soru: soruController.text,
                                                      yanit: _yanitValue,
                                                      zorluk: _zorlukValue,
                                                    );
                                                    if (res == 'success') {
                                                      Navigator.pop(context);
                                                    } else {
                                                      setState(() =>
                                                          _isLoading = false);
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(res),
                                                        ),
                                                      );
                                                    }
                                                  },
                                            child: const Text('Soruyu gönder'),
                                          ),
                                        ],
                                      );
                                    });
                                  });
                            },
                            child: const Text('Soru Ekle'),
                          ),
                          const Divider(),
                          ListView.builder(
                            itemCount: docs.length,
                            shrinkWrap: true,
                            itemBuilder: (context, i) {
                              var element = docs[i].data();
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Soru: ${element['soru']}',
                                    ),
                                    Text(
                                      'Yanıt: ${element['yanıt']}',
                                    ),
                                    Text('Zorluk: ${element['zorluk']}'),
                                    IconButton(
                                      onPressed: () async {
                                        await FirestoreMethods()
                                            .soruSil(element['uid']);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return Container();
              }),
    );
  }
}
