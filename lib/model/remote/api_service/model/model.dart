abstract class Model
{
  String message;
  String status;
  Map<String,dynamic>? data;
  Map<String,dynamic>? errors;

  Model({
    required this.message,
    required this.status,
    this.data,
    this.errors,
  });
}