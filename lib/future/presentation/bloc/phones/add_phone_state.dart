part of 'add_phone_cubit.dart';

@immutable
abstract class AddPhoneState extends Equatable {
  @override
  List<Object> get props => [];
}

class AddPhoneInitial extends AddPhoneState {}

class AddPhoneLoading extends AddPhoneState {}

class AddPhoneLoaded extends AddPhoneState {
  final String phoneId;

  AddPhoneLoaded({required this.phoneId});

  @override
  List<Object> get props => [phoneId];
}

class AddPhoneError extends AddPhoneState {
  final String message;

  AddPhoneError({required this.message});

  @override
  List<Object> get props => [message];
}
