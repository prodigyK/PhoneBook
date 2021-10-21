import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:phone_book/core/error/exception.dart';
import 'package:phone_book/future/data/datasources/departments/department_remote_data_source.dart';
import 'package:phone_book/future/data/models/department_model.dart';

class DepartmentRemoteDataSourceImpl extends DepartmentRemoteDataSource {
  final List<DepartmentModel> _departments = [];

  CollectionReference _collection() {
    return FirebaseFirestore.instance.collection('departments');
  }

  @override
  Future<bool> add(DepartmentModel department) {
    return _collection().add(department.toJson()).then((value) => true).catchError((error) => throw ServerException());
  }

  @override
  Future<bool> update(DepartmentModel department) {
    return _collection()
        .doc(department.id)
        .update(department.toJson())
        .then((value) => true)
        .catchError((error) => throw ServerException());
  }

  @override
  Future<void> remove(DepartmentModel department) {
    return _collection().doc(department.id).delete();
  }

  @override
  Future<List<DepartmentModel>> getAllDepartments() async {
    return await _collection().get().then((snapshot) {
      _departments.clear();
      snapshot.docs.forEach((department) {
        _departments.add(DepartmentModel.fromJson(department.data() as Map<String, dynamic>, docID: department.id));
      });
      return [..._departments];
    }).catchError((error) => throw ServerException());
  }

  @override
  Future<DepartmentModel> getDepartmentById(String depId) async {
    return await _collection().where('depId', isEqualTo: depId).limit(1).get().then((snapshot) {
      return DepartmentModel.fromJson(snapshot.docs[0].data() as Map<String, dynamic>, docID: snapshot.docs[0].id);
    }).catchError((error) => throw ServerException());
  }
}
