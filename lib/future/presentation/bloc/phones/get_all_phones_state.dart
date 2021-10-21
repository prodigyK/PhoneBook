part of 'get_all_phones_cubit.dart';

abstract class GetAllPhonesState extends Equatable {
  const GetAllPhonesState();

  @override
  List<Object> get props => [];
}

class GetAllPhonesInitial extends GetAllPhonesState {}

class GetAllPhonesLoading extends GetAllPhonesState {}

class GetAllPhonesLoaded extends GetAllPhonesState {
  final List<PhoneEntity> phones;

  const GetAllPhonesLoaded({required this.phones});

  @override
  List<Object> get props => [phones];
}

class GetAllPhonesError extends GetAllPhonesState {
  final String message;

  const GetAllPhonesError({required this.message});

  @override
  List<Object> get props => [message];
}
