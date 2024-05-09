// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:keep_in_check/const/network_strings.dart';
// import 'package:keep_in_check/utils/app_utils.dart';

// class FirebaseService {
//   static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   static final _baseDocument = _firestore
//       .collection('users')
//       .doc(FirebaseAuth.instance.currentUser!.uid);

//   static Future<List<Map<String, dynamic>>> getData(
//       {required String collectionName, DateTime? filterDate}) async {
//     final dateId = AppUtils.getDateId(date: filterDate);
//     final docs =
//         await _baseDocument.collection(collectionName).doc(dateId).get();
//     List<Map<String, dynamic>> data = [];
//     for (var doc in docs.data()) {
//       data.add(doc.data());
//     }
//     return data;
//   }

//   static Future<void> setData(
//       String collectionName, Map<String, dynamic> data) async {
//     await _firestore.collection(collectionName).add(data);
//   }

//   static Future<void> updateData(
//       String collectionName, String docId, Map<String, dynamic> newData) async {
//     await _firestore.collection(collectionName).doc(docId).update(newData);
//   }

//   static Future<void> deleteData(String collectionName, String docId) async {
//     await _firestore.collection(collectionName).doc(docId).delete();
//   }
// }
