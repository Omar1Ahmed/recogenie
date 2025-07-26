// To parse this JSON data, do
//
//     final errorReponseModel = errorReponseModelFromJson(jsonString);

import 'dart:convert';

ErrorResponseModel errorResponseModelFromJson(String str) => ErrorResponseModel.fromJson(json.decode(str));

String errorResponseModelToJson(ErrorResponseModel data) => json.encode(data.toJson());

class ErrorResponseModel {
  final String domain;
  final String code;
  final String message;
  final List<FormError>? formErrors;

  ErrorResponseModel({
    required this.domain,
    required this.code,
    required this.message,
    required this.formErrors,
  });

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) => ErrorResponseModel(
    domain: json["domain"],
    code: json["code"],
    message: json["message"],
    formErrors: json["formErrors"] == null ? [] : List<FormError>.from(json["formErrors"].map((x) => FormError.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "domain": domain,
    "code": code,
    "message": message,
    "formErrors": formErrors == null ? [] : List<dynamic>.from(formErrors!.map((x) => x.toJson())),
  };
}

class FormError {
  final String attrName;
  final String code;

  FormError({
    required this.attrName,
    required this.code,
  });

  factory FormError.fromJson(Map<String, dynamic> json) => FormError(
    attrName: json["attrName"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "attrName": attrName,
    "code": code,
  };
}
