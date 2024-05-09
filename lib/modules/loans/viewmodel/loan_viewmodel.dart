import 'package:flutter/material.dart';
import 'package:keep_in_check/modules/loans/controllers/loan_controller.dart';

import '../models/loan_model.dart';

enum LoanType { taken, given }

class LoanViewModel extends ChangeNotifier {
  final LoanController _controller = LoanController();
  LoanType _selectedLoanType = LoanType.given;

  List<LoanModel> _loansGiven = [];
  List<LoanModel> _loansTaken = [];
  List<LoanModel> _paidLoans = [];

  List<LoanModel> get loansGiven => _loansGiven;
  List<LoanModel> get loansTaken => _loansTaken;
  LoanType get selectedLoanType => _selectedLoanType;
  List<LoanModel> get selectedLoanList =>
      _selectedLoanType == LoanType.given ? _loansGiven : _loansTaken;
  List<LoanModel> get paidLoans => _paidLoans;

  void setLoansGiven(List<LoanModel> value) {
    _loansGiven = value;
    notifyListeners();
  }

  void setLoansTaken(List<LoanModel> value) {
    _loansTaken = value;
    notifyListeners();
  }

  void setSelectedLoanType(LoanType value) {
    _selectedLoanType = value;

    notifyListeners();
  }

  Future<void> addALoan(LoanModel loan) async {
    try {
      await _controller.addLoan(loan);
      await getAllLoans();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> markAsPaidUnpaid(LoanModel loan) async {
    try {
      await _controller.markAsPaidUnpaid(loan.id, loan.isPaid);
      await getAllLoans();
      await getPaidLoans();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getPaidLoans() async {
    try {
      _paidLoans = await _controller.getPaidLoans();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getAllLoans() async {
    try {
      _loansGiven = [];
      _loansTaken = [];
      final loans = await _controller.getAllLoans();

      for (var loan in loans) {
        if (loan.isPaid) {
          continue;
        }
        if (loan.type == LoanType.given.name) {
          _loansGiven.add(loan);
        } else {
          _loansTaken.add(loan);
        }
      }

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
