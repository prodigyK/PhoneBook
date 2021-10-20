import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:phone_book/core/consts/failure_consts.dart';
import 'package:phone_book/core/error/failure.dart';
import 'package:phone_book/future/domain/entities/phone_entity.dart';
import 'package:phone_book/future/domain/usecases/phones/get_all_phones.dart';

part 'get_all_phones_state.dart';

class GetAllPhonesCubit extends Cubit<GetAllPhonesState> {
  final GetAllPhonesCase getAllPhonesCase;

  GetAllPhonesCubit({required this.getAllPhonesCase}) : super(GetAllPhonesInitial());

  void getAllPhones() async {
    emit(GetAllPhonesLoading());

    final failureOrPhones = await getAllPhonesCase(PlugParams());
    failureOrPhones.fold((failure) => emit(GetAllPhonesError(message: _mapFailureToString(failure))),
        (phones) => emit(GetAllPhonesLoaded(phones: phones)));
  }

  String _mapFailureToString(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return FailureConsts.SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return FailureConsts.CACHED_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
