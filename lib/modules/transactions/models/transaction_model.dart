import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:keep_in_check/modules/expense_income/models/expense_model.dart';
import 'package:keep_in_check/modules/transactions/viewmodel/transaction_viewmodel.dart';

class TransactionModel {
  final DateTime transactionDate;
  final OperationType operationType;
  final int spentBeforeTransaction;
  final int enteredAmount;
  final int spentAfterTransaction;
  final String id;
  final ExpenseModel performTransactionOn;

  TransactionModel({
    required this.transactionDate,
    required this.operationType,
    required this.id,
    required this.performTransactionOn,
    required this.spentBeforeTransaction,
    required this.spentAfterTransaction,
    required this.enteredAmount,
  });

  static Future<TransactionModel> fromFirestore(DocumentSnapshot doc) async {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return TransactionModel(
      transactionDate: (data['transactionDate']).toDate(),
      operationType: OperationType.values
          .firstWhere((type) => type.name == data['operationType']),
      enteredAmount: data['enteredAmount'] ?? 0,
      spentAfterTransaction: data['spentAfterTransaction'] ?? 0,
      spentBeforeTransaction: data['spentBeforeTransaction'] ?? 0,

      id: doc.id,
      // If IncomeExpenseModel is a Firestore object, you can parse it similarly
      performTransactionOn: ExpenseModel.fromFirestore(
          data['performTransactionOn'], data['performTransactionOn']['id']),
    );
  }

  Map<String, dynamic> toFirestoreObject() {
    return {
      'transactionDate': Timestamp.fromDate(transactionDate),
      'operationType':
          operationType.name.toString(), // Assuming operationType is an enum
      'spentBeforeTransaction': spentBeforeTransaction,
      'enteredAmount': enteredAmount,
      'spentAfterTransaction': spentAfterTransaction,
      'id': id,
      'performTransactionOn':
          ExpenseModel.toFirestoreObject(model: performTransactionOn),
    };
  }
}
