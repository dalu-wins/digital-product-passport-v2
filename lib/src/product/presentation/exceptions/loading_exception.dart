class LoadingException implements Exception {
  final String message;
  LoadingException([this.message = 'Fehler beim Laden']);

  @override
  String toString() => 'LoadingException: $message';
}
