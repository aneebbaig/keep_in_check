import 'package:cloud_firestore/cloud_firestore.dart';

class LoanModel {
  final String id;
  final String name;
  final String phno;
  final int amount;
  final bool isPaid;
  final String type;

  LoanModel(
      {required this.id,
      required this.name,
      required this.phno,
      required this.type,
      required this.isPaid,
      required this.amount});

  static LoanModel fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return LoanModel(
      name: data['name'],
      phno: data['phoneNumber'],
      amount: data['amount'],
      id: doc.id,
      isPaid: data['isPaid'],
      type: data['type'],
    );
  }

  Map<String, dynamic> toFirestoreObject() {
    return {
      'name': name,
      'phoneNumber': phno,
      'amount': amount,
      'type': type,
      'isPaid': isPaid,
    };
  }
}
