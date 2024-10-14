class ResponseModel {
  final String message;
  final bool success;
  final dynamic data;

  ResponseModel({
    required this.message,
    required this.success,
    required this.data,
  });
}
