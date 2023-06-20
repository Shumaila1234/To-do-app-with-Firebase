// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:todofirebase/model/response.dart';
// import 'package:todofirebase/model/todo.dart';

// final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// final CollectionReference collectionReference = _firestore.collection('Todo');
// final CollectionReference collectionReference1 =
//     FirebaseFirestore.instance.collection('your_collection_name');

// class FirebaseCrud {
//   static Future<Response> addTodo({
//     required String task,
//     required String startDate,
//     required String startTime,
//   }) async {
//     Response response = Response();
//     DocumentReference documentReferencer = collectionReference.doc();

//     Map<String, dynamic> data = <String, dynamic>{
//       "task": task,
//       "startDate": startDate,
//       "startTime": startTime
//     };

//     await documentReferencer.set(data).whenComplete(() {
//       response.code = 200;
//       response.message = "Task added.";
//     }).catchError((e) {
//       response.code = 500;
//       response.message = e;
//     });

//     return response;
//   }

//   static Future<Response> updateTodo({
//     required String task,
//     required String startDate,
//     required String startTime,
//     required String docId,
//   }) async {
//     Response response = Response();
//     DocumentReference documentReferencer = collectionReference.doc(docId);

//     Map<String, dynamic> data = <String, dynamic>{
//       "task": task,
//       "startDate": startDate,
//       "startTime": startTime
//     };

//     await documentReferencer.update(data).whenComplete(() {
//       response.code = 200;
//       response.message = "Task updated.";
//     }).catchError((e) {
//       response.code = 500;
//       response.message = e;
//     });

//     return response;
//   }

//   static Stream<QuerySnapshot> readTodo() {
//     CollectionReference notesItemCollection = collectionReference;

//     return notesItemCollection.snapshots();
//   }

//   static Future<Response> deleteTodo({
//     required String docId,
//   }) async {
//     Response response = Response();
//     DocumentReference documentReferencer = collectionReference.doc(docId);

//     await documentReferencer.delete().whenComplete(() {
//       response.code = 200;
//       response.message = "Task deleted";
//     }).catchError((e) {
//       response.code = 500;
//       response.message = e;
//     });

//     return response;
//   }

//   Stream<List<Todo>> getDataFromFirebase() {
//     return collectionReference.snapshots().map(
//       (QuerySnapshot querySnapshot) {
//         return querySnapshot.docs.map(
//           (DocumentSnapshot documentSnapshot) {
//             return Todo.fromJson(
//                 documentSnapshot.data() as Map<String, dynamic>);
//           },
//         ).toList();
//       },
//     );
//   }
// }
