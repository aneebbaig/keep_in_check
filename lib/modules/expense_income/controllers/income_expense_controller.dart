import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:keep_in_check/modules/expense_income/models/expense_model.dart';
import 'package:keep_in_check/services/snackbar_service.dart';

import 'package:keep_in_check/utils/app_utils.dart';

import '../../../models/firebase_exception.dart';
import '../models/income_model.dart';

class IncomeExpenseController {
  Future<void> addIncome({
    required String name,
    required int amount,
    required bool isUSD,
    required DateTime createdAt,
    required bool isExtra,
  }) async {
    try {
      final CollectionReference incomeRef = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('userIncome');

      final income = IncomeModel.toFirestoreObject(
        model: IncomeModel(
          createdAt: createdAt,
          id: "",
          name: name,
          amount: amount,
          isUSD: isUSD,
          isExtra: isExtra,
        ),
      );
      await incomeRef.add(income);
    } catch (e) {
      throw CustomFirebaseException(
        message: e.toString(),
        code: 'add_income_expense_error',
      );
    }
  }

  Future<void> addExpense({
    required String name,
    required int budget,
    required DateTime dateTime,
    required bool isExtra,
  }) async {
    try {
      final CollectionReference expenseRef = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('userExpenses');

      final expense = ExpenseModel.toFirestoreObject(
        model: ExpenseModel(
          createdAt: dateTime,
          id: "",
          name: name,
          budget: budget,
          isExtra: isExtra,
        ),
      );
      await expenseRef.add(expense);
    } catch (e) {
      throw CustomFirebaseException(
        message: e.toString(),
        code: 'add_income_expense_error',
      );
    }
  }

  Future<void> deleteExpense({required String id}) async {
    try {
      final CollectionReference expenseRef = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('userExpenses');

      await expenseRef.doc(id).delete();
      SnackbarService.showSnackbar("Deleted");
    } catch (e) {
      throw CustomFirebaseException(
        message: e.toString(),
        code: 'delete_expense_error',
      );
    }
  }

  Future<void> deleteIncome({required String id}) async {
    try {
      final CollectionReference incomeRef = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('userIncome');

      await incomeRef.doc(id).delete();
      SnackbarService.showSnackbar("Deleted");
    } catch (e) {
      throw CustomFirebaseException(
        message: e.toString(),
        code: 'delete_incom_error',
      );
    }
  }

  Future<void> updateExpense(
      {required String name,
      required int budget,
      required String id,
      required DateTime createdAt,
      required bool isExtra,
      required int spentBudget,
      required}) async {
    try {
      final CollectionReference expenseRef = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('userExpenses');

      final expense = ExpenseModel.toFirestoreObject(
        model: ExpenseModel(
          createdAt: createdAt,
          id: id,
          name: name,
          budget: budget,
          isExtra: isExtra,
          spentBudget: spentBudget,
        ),
      );

      await expenseRef.doc(id).update(expense);
    } catch (e) {
      throw CustomFirebaseException(
        message: e.toString(),
        code: 'update_expense_error',
      );
    }
  }

  Future<void> updateIncome({
    required String name,
    required int amount,
    required String id,
    required bool isUSD,
    required DateTime createdAt,
    required bool isExtra,
  }) async {
    try {
      final CollectionReference incomeRef = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('userIncome');

      final income = IncomeModel.toFirestoreObject(
        model: IncomeModel(
          createdAt: createdAt,
          id: id,
          name: name,
          amount: amount,
          isUSD: isUSD,
          isExtra: isExtra,
        ),
      );

      await incomeRef.doc(id).update(income);
    } catch (e) {
      throw CustomFirebaseException(
        message: e.toString(),
        code: 'add_income_expense_error',
      );
    }
  }

  Future<List<IncomeModel>> getAllIncome({DateTime? dateTime}) async {
    List<IncomeModel> income = [];
    dateTime ??= DateTime.now();
    final (startTimestamp, endTimestamp) = AppUtils.getStartEndDate(dateTime);
    try {
      final CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      final snapshot = await users
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('userIncome')
          .where('createdAt', isGreaterThanOrEqualTo: startTimestamp)
          .where('createdAt', isLessThan: endTimestamp)
          .get();
      income = await Future.wait(
        snapshot.docs.map(
          (doc) async {
            return await IncomeModel.fromFirestore(doc.data(), doc.id);
          },
        ),
      );
      return income;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ExpenseModel>> getAllExpenses({DateTime? dateTime}) async {
    List<ExpenseModel> expenses = [];
    dateTime ??= DateTime.now();
    final (startTimestamp, endTimestamp) = AppUtils.getStartEndDate(dateTime);
    try {
      final CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      final snapshot = await users
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('userExpenses')
          .where('createdAt', isGreaterThanOrEqualTo: startTimestamp)
          .where('createdAt', isLessThan: endTimestamp)
          .get();
      expenses = await Future.wait(snapshot.docs.map((doc) async {
        return ExpenseModel.fromFirestore(doc.data(), doc.id);
      }));
      return expenses;
    } catch (e) {
      rethrow;
    }
  }
}
