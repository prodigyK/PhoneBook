part of 'update_phone_cubit.dart';

abstract class UpdatePhoneState extends Equatable {
  const UpdatePhoneState();

  @override
  List<Object> get props => [];
}

class UpdatePhoneInitial extends UpdatePhoneState {}

class UpdatePhoneLoading extends UpdatePhoneState {}

class UpdatePhoneLoaded extends UpdatePhoneState {
  final bool isUpdated;

  const UpdatePhoneLoaded({required this.isUpdated});

  @override
  List<Object> get props => [isUpdated];
}

class UpdatePhoneError extends UpdatePhoneState {
  final String message;

  const UpdatePhoneError({required this.message});

  @override
  List<Object> get props => [message];
}
