class CustomFirebaseException implements Exception {
  final String message;
  final String code;

  CustomFirebaseException({required this.message, required this.code});

  @override
  String toString() {
    return 'FirebaseException: $message, code: $code';
  }
}
