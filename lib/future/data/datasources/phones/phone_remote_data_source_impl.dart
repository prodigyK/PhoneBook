import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logging/logging.dart';
import 'package:phone_book/core/error/exception.dart';
import 'package:phone_book/future/data/datasources/phones/phone_remote_data_source.dart';
import 'package:phone_book/future/data/models/phone_model.dart';
import 'package:phone_book/service_locator.dart' as di;

class PhoneRemoteDataSourceImpl implements PhoneRemoteDataSource {
  final List<PhoneModel> _phones = [];
  final log = di.sl<Logger>();
  final FirebaseFirestore instance;

  PhoneRemoteDataSourceImpl({required this.instance});

  List<PhoneModel> get phone => [..._phones];

  CollectionReference _collection() {
    return instance.collection('phones');
  }

  @override
  Future<String> addPhone(PhoneModel phone) {
    log.fine('Call addPhone() method: $phone');
    return _collection().add(phone.toJson()).then((value) => value.id).catchError((error) => throw ServerException());
  }

  @override
  Future<void> updatePhone(PhoneModel phone) {
    log.fine('Call updatePhone() method: $phone');
    return _collection()
        .doc(phone.id)
        .update(phone.toJson())
        .catchError((error) => throw ServerException());
  }

  @override
  Future<void> removePhone(PhoneModel phone) {
    log.fine('Call removePhone() method: $phone');
    return _collection().doc(phone.id).delete();
  }

  @override
  Future<List<PhoneModel>> getAllPhones() async {
    log.info('Call getAllPhones() method');
    return await _collection().get().then((snapshot) {
      _phones.clear();
      snapshot.docs.forEach((phone) {
        _phones.add(PhoneModel.fromJson(phone.data() as Map<String, dynamic>, docID: phone.id));
      });
      return [..._phones];
    }).catchError((error) => throw ServerException());
  }

  @override
  Future<List<PhoneModel>> getPhonesByDepartment(String depId) async {
    log.fine('Call getPhonesByDepartment() method: $depId');
    List<PhoneModel> phones = [];
    return await _collection().where('depId', isEqualTo: depId).get().then((snapshot) {
      for (var phone in snapshot.docs) {
        phones.add(PhoneModel.fromJson(phone.data() as Map<String, dynamic>));
      }
      return phones;
    }).catchError((error) => throw ServerException());
  }

  @override
  Future<List<PhoneModel>> searchNameByNumber(String number) async {
    log.fine('Call searchNameByNumber() method: $number');
    List<PhoneModel> phones = [];
    return await _collection().where('number', isEqualTo: number).get().then((snapshot) {
      for (var phone in snapshot.docs) {
        phones.add(PhoneModel.fromJson(phone.data() as Map<String, dynamic>));
      }
      return phones;
    }).catchError((error) => throw ServerException());
  }

  @override
  Future<List<PhoneModel>> searchPhonesByName(String query) async {
    log.fine('Call searchPhonesByName() method: $query');
    List<PhoneModel> phones = [];
    return await _collection().where('name', isEqualTo: query).get().then((snapshot) {
      for (var phone in snapshot.docs) {
        phones.add(PhoneModel.fromJson(phone.data() as Map<String, dynamic>));
      }
      return phones;
    }).catchError((error) => throw ServerException());
  }
}
