import 'package:equatable/equatable.dart';

class DepartmentEntity extends Equatable {
  final String id;
  final String name;
  final String parentId;
  final String ordering;

  const DepartmentEntity({
    required this.id,
    required this.name,
    required this.parentId,
    required this.ordering,
  });

  @override
  List<Object> get props => [id, name, parentId, ordering];
}
