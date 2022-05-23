import 'package:flutter_application_3/soru.dart';

class TestVeri {
  int _soruDegis = 0;

  //"_" private olarak tanımlandırıyor.
  List<Soru> _soruBankasi = [
    Soru(
        soruMetni:
            "C++ dili Bell Laboratuvarlarında Bjarne Stroustrup tarafından 1979 yılından itibaren geliştirilmeye başlanmıştır",
        soruYaniti: true),
    Soru(
        soruMetni:
            "Bitcoin Smart Contract ve WhitePaperı 3 Ocak 2009 yılında Satoshi Nakamoto takma isimli bir developer tarafından yazılmıştır",
        soruYaniti: true),
    Soru(soruMetni: "C nesne tabanlı bir dildir", soruYaniti: false),
    Soru(
        soruMetni: "Dünyanın en büyük yüzölçümüne sahip ülkesi Rusyadır",
        soruYaniti: true),
    Soru(soruMetni: "Html bir programlama dilidir", soruYaniti: false),
    Soru(
        soruMetni: "Ethereum block zincirinde Gerçek validatörler kullanılır",
        soruYaniti: true),
    Soru(
        soruMetni: "Php dili Rasmus Lerdorf tarafından geliştirilmiştir",
        soruYaniti: true),
  ];
  String getSoruMetni() {
    return _soruBankasi[_soruDegis].soruMetni;
  }

  bool getSoruYaniti() {
    return _soruBankasi[_soruDegis].soruYaniti;
  }

  void setSoruDegis(int index) {
    this._soruDegis = index;
  }

  void sonrakiSoru() {
    if (_soruDegis < _soruBankasi.length - 1) {
      _soruDegis++;
    }
  }

  bool testBittimi() {
    if (_soruDegis >= _soruBankasi.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  void testiSifirla() {
    _soruDegis = 0;
  }
}
