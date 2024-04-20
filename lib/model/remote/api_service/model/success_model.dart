import 'model.dart';

class SuccessModel extends Model
{

  SuccessModel({
    required super.status,
    required super.message,
    super.data,
});

  factory SuccessModel.fromJson(Map<String,dynamic> data)
  {
    return SuccessModel(
        status: data['status'],
        message: data['msg'],
        data: data['data'],
    );
  }
}
