class ProcessResponse<T> {
  final String message;
  final bool success;
  late T object;

  ProcessResponse(this.message, [this.success = true]);
}
