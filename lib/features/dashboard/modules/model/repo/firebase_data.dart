import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_fcii/features/dashboard/modules/model/repo/parent_data.dart';
import 'package:project_fcii/features/dashboard/modules/model/entity/product_model.dart';

class FirebaseRepo extends ParentRepo {
  static FirebaseRepo instance = FirebaseRepo._init();

  FirebaseRepo._init();

  @override
  Future<List<ProductModel>> fetch() async {
    return await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      return querySnapshot.docs.map((e) {
        final Map data = e.data() as Map;

        Map m = {
          'name': data.containsKey('name') ? data['name'] : "XX",
          'address': data.containsKey('adress') ? data['address'] : "XXXX",
          'id': e.reference.id,
        };
        return ProductModel.fromJson(m);
      }).toList();
    });
  }

  @override
  Future<void> delete({required int id}) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.doc(id.toString()).delete();
  }

  @override
  Future<void> insert({required String name, String? address}) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users
        .add({
          'full_name': name, // John Doe
          'address': address, // Stokes and Sons
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
