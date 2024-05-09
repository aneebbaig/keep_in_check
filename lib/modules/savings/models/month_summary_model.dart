import 'savings_model.dart';

class MonthSummary {
  String monthAndYear;
  int totalSavingsPKR;
  int totalSavingsUSD;
  final List<SavingsModel> savingsList;

  MonthSummary({
    required this.monthAndYear,
    required this.totalSavingsPKR,
    required this.totalSavingsUSD,
    required this.savingsList,
  });
}
