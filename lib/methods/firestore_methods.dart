import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_3/models/soru_model.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  //Referans
  final _ref = FirebaseFirestore.instance;

  //Soruları veritabanından getirme fonksiyonu
  Future<List> sorulariGetir(String zorlukDerecesi) async {
    List list = [];
    try {
      //Zorluk derecesine göre veritabanından getirdik
      var data = await _ref
          .collection('sorular')
          .where('zorluk', isEqualTo: zorlukDerecesi)
          .get();
      //Gelen QuerySnapshot'un içerisinden listeyi aldık
      list = data.docs;
    } catch (e) {
      list = [];
    }

    return list;
  }

  Future<void> soruSil(String soruUid) async {
    try {
      await _ref.collection('sorular').doc(soruUid).delete();
    } catch (e) {
      e.toString();
    }
  }

  Future<String> soruEkle({
    required String soru,
    required bool yanit,
    required String zorluk,
  }) async {
    String res = 'error';
    try {
      String soruUid = const Uuid().v4();
      var model = SoruModel(
        soruUid: soruUid,
        soruMetni: soru,
        soruYaniti: yanit,
        zorlukDerecesi: zorluk,
      );

      await _ref.collection('sorular').doc(soruUid).set(model.toJson());
      res = 'success';
    } catch (e) {
      res = e.toString();
    }

    return res;
  }
}
