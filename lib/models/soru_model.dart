class SoruModel {
  final String soruUid;
  final String soruMetni;
  final bool soruYaniti;
  final String zorlukDerecesi;

  SoruModel({
    required this.soruUid,
    required this.soruMetni,
    required this.soruYaniti,
    required this.zorlukDerecesi,
  });

  Map<String, dynamic> toJson() => {
        'uid': soruUid,
        'soru': soruMetni,
        'yanıt': soruYaniti,
        'zorluk': zorlukDerecesi,
      };
}
