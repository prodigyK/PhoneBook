import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:phone_book/core/consts/failure_consts.dart';
import 'package:phone_book/core/error/failure.dart';
import 'package:phone_book/future/domain/entities/phone_entity.dart';
import 'package:phone_book/future/domain/usecases/phones/get_phones_by_department.dart';

part 'get_phones_by_department_state.dart';

class GetPhonesByDepartmentCubit extends Cubit<GetPhonesByDepartmentState> {
  final GetPhonesByDepartmentCase getPhonesByDepartmentCase;

  GetPhonesByDepartmentCubit({required this.getPhonesByDepartmentCase}) : super(GetPhonesByDepartmentInitial());

  Future<List<PhoneEntity>> getPhonesByDepartment({required String depId}) async {
    emit(GetPhonesByDepartmentLoading());

    final failureOrPhones = await getPhonesByDepartmentCase(DepartmentIdParams(id: depId));

    List<PhoneEntity> phonesList = [];
    failureOrPhones.fold(
      (failure) => emit(GetPhonesByDepartmentError(message: _mapFailureToString(failure))),
      (phones) {
        emit(GetPhonesByDepartmentLoaded(phones: phones));
        phonesList = phones;
      },
    );
    return phonesList;
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
