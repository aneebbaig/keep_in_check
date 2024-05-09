
class SavingsModel {
  final String id;
  final DateTime dateTime;
  final int savingAmount;
  final bool isUSD;

  SavingsModel({
    required this.dateTime,
    required this.savingAmount,
    required this.isUSD,
    required this.id,
  });

  Map<String, dynamic> toFirestoreObject() {
    return {
      "dateTime": dateTime,
      "savingAmount": savingAmount,
      "isUSD": isUSD,
    };
  }

  factory SavingsModel.fromFirestore(Map<String, dynamic> data, String id) {
    return SavingsModel(
      dateTime: data['dateTime'].toDate(),
      savingAmount: data['savingAmount'],
      isUSD: data['isUSD'],
      id: id,
    );
  }
}
