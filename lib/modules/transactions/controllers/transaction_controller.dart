import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:keep_in_check/modules/expense_income/models/expense_model.dart';

import '../../../models/firebase_exception.dart';
import '../models/transaction_model.dart';

class TransactionController {
  Future<void> performTransaction({
    required int amount,
    required ExpenseModel perfromTransactionOn,
  }) async {
    try {
      final document = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("userExpenses")
          .doc(perfromTransactionOn.id);

      await document.update({
        'spentBudget': amount,
      });
    } catch (e) {
      throw CustomFirebaseException(
        message: e.toString(),
        code: 'perform_transaction_error',
      );
    }
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    try {
      final transactions = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('userTransactions');

      // Add the TransactionModel object to the transactions collection
      await transactions.add(transaction.toFirestoreObject());
    } catch (e) {
      throw CustomFirebaseException(
        message: e.toString(),
        code: 'add_transaction_error',
      );
    }
  }

  Future<List<TransactionModel>> getAllTransactions() async {
    List<TransactionModel> transactions = [];
    try {
      final CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      final snapshot = await users
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('userTransactions')
          .get();
      transactions = await Future.wait(snapshot.docs.map(
        (doc) async {
          return await TransactionModel.fromFirestore(doc);
        },
      ).toList());

      return transactions;
    } catch (e) {
      throw CustomFirebaseException(
        message: e.toString(),
        code: 'get_all_transaction_error',
      );
    }
  }
}
