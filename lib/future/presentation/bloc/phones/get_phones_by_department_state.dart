part of 'get_phones_by_department_cubit.dart';

abstract class GetPhonesByDepartmentState extends Equatable {
  const GetPhonesByDepartmentState();

  @override
  List<Object> get props => [];
}

class GetPhonesByDepartmentInitial extends GetPhonesByDepartmentState {}

class GetPhonesByDepartmentLoading extends GetPhonesByDepartmentState {}

class GetPhonesByDepartmentLoaded extends GetPhonesByDepartmentState {
  final List<PhoneEntity> phones;

  const GetPhonesByDepartmentLoaded({required this.phones});

  @override
  List<Object> get props => [phones];
}

class GetPhonesByDepartmentError extends GetPhonesByDepartmentState {
  final String message;

  const GetPhonesByDepartmentError({required this.message});

  @override
  List<Object> get props => [message];
}
