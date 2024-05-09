// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:keep_in_check/modules/expense_income/models/income_expense_edit_args.dart';
// import 'package:keep_in_check/routing/app_routes.dart';
// import 'package:keep_in_check/routing/router.dart';
// import 'package:keep_in_check/widgets/custom/custom_list_tile.dart';
// import 'package:keep_in_check/widgets/dialogs/do_transaction_dialog.dart';

// import '../../../../../utils/app_utils.dart';
// import '../../../../../widgets/add_height_width.dart';
// import '../../../../../widgets/custom/custom_text_widget.dart';
// import '../../../models/income_model.dart';

// class IncomeExpenseListTile extends StatelessWidget {
//   final IncomeModel incomeExpenseModel;
//   final bool isIncome;

//   const IncomeExpenseListTile({
//     super.key,
//     required this.incomeExpenseModel,
//     required this.isIncome,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return CustomListTile(
//       child: Row(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CustomText(
//                 incomeExpenseModel.name,
//                 style: Theme.of(context).textTheme.headlineSmall!.copyWith(
//                       fontWeight: FontWeight.bold,
//                     ),
//               ),
//               const AddHeight(0.01),
//               CustomText(
//                   "PKR ${incomeExpenseModel.amountPkr.formatAsDecimals().toString()}",
//                   style: Theme.of(context).textTheme.bodyLarge),
//               if (incomeExpenseModel.amountUsd != 0)
//                 CustomText(
//                     "\$ ${incomeExpenseModel.amountUsd.formatAsDecimals().toString()}",
//                     style: Theme.of(context).textTheme.bodyLarge),
//             ],
//           ),
//           const Spacer(),
//           IconButton(
//             visualDensity: VisualDensity.compact,
//             padding: EdgeInsets.zero,
//             onPressed: () {
//               AppNavigator.pushNamed(
//                 AppRoutes.addUpdateIncomeOrExpenseRoute,
//                 arguments: IncomeExpenseUpdateArgs(
//                   model: incomeExpenseModel,
//                 ),
//               );
//             },
//             icon: const Icon(
//               Icons.edit,
//             ),
//           ),
//           if (!isIncome)
//             IconButton(
//               visualDensity: VisualDensity.compact,
//               padding: EdgeInsets.zero,
//               onPressed: () {
//                 AppUtils.showDialogWithContent(
//                   context: context,
//                   barrierDismissable: false,
//                   heading: "Perform a Transaction",
//                   dialog: DoTransactionDialog(
//                     model: incomeExpenseModel,
//                   ),
//                 );
//               },
//               icon: const Icon(
//                 CupertinoIcons.plus_slash_minus,
//               ),
//             )
//         ],
//       ),
//     );
//   }
// }
