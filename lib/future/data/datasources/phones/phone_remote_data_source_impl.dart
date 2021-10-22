import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:phone_book/core/error/exception.dart';
import 'package:phone_book/future/data/datasources/phones/phone_remote_data_source.dart';
import 'package:phone_book/future/data/models/phone_model.dart';

class PhoneRemoteDataSourceImpl implements PhoneRemoteDataSource {
  final List<PhoneModel> _phones = [];

  List<PhoneModel> get phone => [..._phones];

  CollectionReference _collection() {
    return FirebaseFirestore.instance.collection('phones');
  }

  @override
  Future<bool> addPhone(PhoneModel phone) {
    return _collection().add(phone.toJson()).then((value) => true).catchError((error) => throw ServerException());
  }

  @override
  Future<bool> updatePhone(PhoneModel phone) {
    return _collection().doc(phone.id).update(phone.toJson()).then((value) => true).catchError((error) => throw ServerException());
  }

  @override
  Future<void> removePhone(PhoneModel phone) {
    return _collection().doc(phone.id).delete();
  }

  @override
  Future<List<PhoneModel>> getAllPhones() async {
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
    List<PhoneModel> phones = [];
    return await _collection().where('name', isEqualTo: query).get().then((snapshot) {
      for (var phone in snapshot.docs) {
        phones.add(PhoneModel.fromJson(phone.data() as Map<String, dynamic>));
      }
      return phones;
    }).catchError((error) => throw ServerException());
  }
}
