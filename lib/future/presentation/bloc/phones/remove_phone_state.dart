part of 'remove_phone_cubit.dart';

abstract class RemovePhoneState extends Equatable {
  const RemovePhoneState();

  @override
  List<Object> get props => [];
}

class RemovePhoneInitial extends RemovePhoneState {}

class RemovePhoneLoading extends RemovePhoneState {}

class RemovePhoneLoaded extends RemovePhoneState {}

class RemovePhoneError extends RemovePhoneState {
  final String message;

  const RemovePhoneError({required this.message});

  @override
  List<Object> get props => [message];
}
