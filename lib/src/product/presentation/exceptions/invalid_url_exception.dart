class InvalidUrlException implements Exception {
  final String message;
  InvalidUrlException([this.message = 'Ungültige URL']);

  @override
  String toString() => 'InvalidUrlException: $message';
}
