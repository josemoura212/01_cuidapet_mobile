class FailureException implements Exception {
  final String? message;

  FailureException({required this.message});
}
