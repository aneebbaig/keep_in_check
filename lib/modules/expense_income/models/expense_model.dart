import 'package:cloud_firestore/cloud_firestore.dart';

class ExpenseModel {
  final DateTime createdAt;
  final String id;
  final String name;
  final int budget;
  final int spentBudget;
  final bool isExtra;

  ExpenseModel({
    required this.createdAt,
    required this.id,
    required this.name,
    required this.budget,
    required this.isExtra,
    this.spentBudget = 0,
  });

  static Map<String, dynamic> toFirestoreObject({required ExpenseModel model}) {
    Map<String, Object> formData = {
      'id': model.id,
      'createdAt': Timestamp.fromDate(model.createdAt),
      'name': model.name,
      'budget': model.budget,
      'isExtra': model.isExtra,
      'spentBudget': model.spentBudget,
    };

    return formData;
  }

  static ExpenseModel fromFirestore(Map<String, dynamic> data, String id) {
    //final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final DateTime dateTime = data['createdAt'].toDate();
    final String name = data['name'];
    final int budget = data['budget'];
    final bool isExtra = data['isExtra'];

    return ExpenseModel(
      createdAt: dateTime,
      id: id,
      name: name,
      budget: budget,
      isExtra: isExtra,
      spentBudget: data['spentBudget'],
    );
  }
}
