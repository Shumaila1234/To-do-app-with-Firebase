import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todofirebase/model/response.dart';
import 'package:todofirebase/model/todo.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  addTodo(Todo employeeData) async {
    Response response = Response();
    await _db.collection("Todo").add(employeeData.toMap()).whenComplete(() {
      response.code = 200;
      response.message = "Task added.";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  updateTodo(Todo employeeData) async {
    Response response = Response();
    await _db
        .collection("Todo")
        .doc(employeeData.id)
        .update(employeeData.toMap())
        .whenComplete(() {
      response.code = 200;
      response.message = "Task updated.";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  deleteTodo1(String documentId) async {
    Response response = Response();
    await _db.collection("Todo").doc(documentId).delete().whenComplete(() {
      response.code = 200;
      response.message = "Task deleted.";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  Future<Response> deleteTodo({
    required String docId,
  }) async {
    Response response = Response();
    // DocumentReference documentReferencer = _db.doc(docId);

    await _db.collection("Todo").doc(docId).delete().whenComplete(() {
      response.code = 200;
      response.message = "Task deleted";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  Future<List<Todo>> retrieveTodo() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("Todo").get();
    return snapshot.docs
        .map((docSnapshot) => Todo.fromDocumentSnapshot(docSnapshot))
        .toList();
  }
}
