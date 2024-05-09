import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/app_utils.dart';

class IncomeModel {
  final DateTime createdAt;
  final String id;
  final String name;
  final int amount;
  final bool isUSD;
  final bool isExtra;
  final int? convertedAmount;

  IncomeModel({
    required this.createdAt,
    required this.id,
    required this.name,
    required this.amount,
    required this.isUSD,
    required this.isExtra,
    this.convertedAmount,
  });

  static Map<String, dynamic> toFirestoreObject({required IncomeModel model}) {
    Map<String, Object> formData = {
      'createdAt': Timestamp.fromDate(model.createdAt),
      'name': model.name,
      'amount': model.amount,
      'isUSD': model.isUSD,
      'isExtra': model.isExtra,
    };

    return formData;
  }

  static Future<IncomeModel> fromFirestore(
      Map<String, dynamic> data, String id) async {
    //final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final bool isUSD = data['isUSD'];
    final DateTime dateTime = data['createdAt'].toDate();
    final String name = data['name'];
    final int amount = data['amount'];
    final bool isExtra = data['isExtra'];
    int? converted;
    if (isUSD) {
      converted = await AppUtils.convertToPKR(amount);
    }

    return IncomeModel(
      createdAt: dateTime,
      id: id,
      name: name,
      amount: amount,
      isUSD: isUSD,
      convertedAmount: converted,
      isExtra: isExtra,
    );
  }
}
