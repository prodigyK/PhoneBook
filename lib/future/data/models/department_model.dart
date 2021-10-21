import 'package:phone_book/future/domain/entities/department_entity.dart';

class DepartmentModel extends DepartmentEntity {
  const DepartmentModel({
    required id,
    required depId,
    required name,
    required parentId,
    required ordering,
  }) : super(
          id: id,
          depId: depId,
          name: name,
          parentId: parentId,
          ordering: ordering,
        );

  factory DepartmentModel.fromJson(Map<String, dynamic> json, {String? docID}) {
    return DepartmentModel(
      id: docID ?? '',
      depId: json['id'],
      name: json['name'],
      parentId: json['parentId'],
      ordering: json['ordering'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'depId': depId,
      'name': name,
      'parentId': parentId,
      'ordering': ordering,
    };
  }
}
