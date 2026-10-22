import 'dart:convert';

export 'paginated_response.dart';

class ApiResponse<T> {
  ApiResponse._(); // private constructor
  factory ApiResponse.success({required bool status,
    required String message, required T data}) = SuccessResponse<T>;

  factory ApiResponse.error({dynamic status,
    required String message, T? data}) = ErrorResponse<T>;
}

class ErrorResponse<T> extends ApiResponse<T> {
  ErrorResponse({this.status, required this.message, this.data})
      : super._();
  final dynamic status;
  final String message;
  final T? data;

  ErrorResponse copyWith({
    dynamic status,
    String? message,
    T? data,
  }) =>
      ErrorResponse(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  String toJson() => json.encode(toMap());

  factory ErrorResponse.fromMap(Map<dynamic, dynamic> json, [T? errors]) =>
      ErrorResponse(status: json["status"], message: json["message"], data: errors);

  Map<String, dynamic> toMap() => {
    "status": status,
    "message": message,
    "data": data,
  };
}

class SuccessResponse<T> extends ApiResponse<T> {
  SuccessResponse({required this.status, required this.message, required this.data})
      : super._();
  final dynamic status;
  final String? message;
  final T? data;

  SuccessResponse copyWith({
    dynamic status,
    String? message,
    T? data,
  }) =>
      SuccessResponse(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  String toJson() => json.encode(toMap());

  factory SuccessResponse.fromMap(Map<String, dynamic> json,
      {T? data}) =>
      SuccessResponse(status: json["status"], message: json["message"], data: data);

  Map<String, dynamic> toMap() => {
    "status": status,
    "message": message,
    "data": data,
  };
}
