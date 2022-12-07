class TestVeri {
  final List sorular;
  TestVeri({required this.sorular});

  int _soruDegis = 0;

  //"_" private olarak tanımlandırıyor.

  String getSoruMetni() {
    if (sorular.isEmpty) {
      return 'error';
    }
    return sorular[_soruDegis].data()['soru'];
  }

  bool getSoruYaniti() {
    return sorular[_soruDegis].data()['yanıt'];
  }

  void setSoruDegis(int index) {
    _soruDegis = index;
  }

  void sonrakiSoru() {
    if (_soruDegis < sorular.length - 1) {
      _soruDegis++;
    }
  }

  bool testBittimi() {
    if (_soruDegis >= sorular.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  void testiSifirla() {
    _soruDegis = 0;
  }
}
