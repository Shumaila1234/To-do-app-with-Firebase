import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todofirebase/model/address.dart';

class Todo {
  String? taskDescription;
  String? id;
  String? startTime;
  String? startDate;
  Todo({this.id, this.startDate, this.startTime, this.taskDescription});

  Map<String, dynamic> toMap() {
    return {
      'taskDescription': taskDescription,
      'id': id,
      'startTime': startTime,
      'startDate': startDate
    };
  }

  Todo.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        taskDescription = doc.data()!["taskDescription"],
        startTime = doc.data()!["startTime"],
        startDate = doc.data()!["startDate"];
}
