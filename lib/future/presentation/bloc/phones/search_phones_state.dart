part of 'search_phones_cubit.dart';

abstract class SearchPhonesState extends Equatable {
  const SearchPhonesState();

  @override
  List<Object> get props => [];
}

class SearchPhonesInitial extends SearchPhonesState {}

class SearchPhonesLoading extends SearchPhonesState {}

class SearchPhonesLoaded extends SearchPhonesState {
  final List<PhoneEntity> phones;

  SearchPhonesLoaded({required this.phones});

  @override
  List<Object> get props => [phones];
}

class SearchPhonesError extends SearchPhonesState {
  final String message;

  SearchPhonesError({required this.message});

  @override
  List<Object> get props => [message];
}
