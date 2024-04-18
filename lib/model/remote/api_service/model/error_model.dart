import 'model.dart';

class ErrorModel extends Model
{

  ErrorModel({
    required super.message,
    required super.status,
    required super.errors,
  });

  factory ErrorModel.fromJson(Map<String,dynamic> data)
  {
    return ErrorModel(
      status: data['status'],
      message: data['msg'],
      errors: data['errors']?? {},
    );
  }
}