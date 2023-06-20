// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:todofirebase/core/add_task/arguments/add_task_arguments.dart';
// import 'package:todofirebase/firebase/todo_firebase_new.dart';
// import 'package:todofirebase/model/employee.dart';
// import 'package:todofirebase/utils/app_navigations.dart';
// import 'package:todofirebase/utils/app_route_name.dart';

// class Dashboard extends StatefulWidget {
//   const Dashboard({super.key});

//   @override
//   State<Dashboard> createState() => _DashboardState();
// }

// class _DashboardState extends State<Dashboard> {
//   DatabaseService service = DatabaseService();
//   Future<List<Employee>>? employeeList;
//   List<Employee>? retrievedEmployeeList;
//   @override
//   void initState() {
//     super.initState();
//     _initRetrieval();
//   }

//   Future<void> _initRetrieval() async {
//     employeeList = service.retrieveEmployees();
//     retrievedEmployeeList = await service.retrieveEmployees();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: FutureBuilder(
//           future: employeeList,
//           builder:
//               (BuildContext context, AsyncSnapshot<List<Employee>> snapshot) {
//             if (snapshot.hasData && snapshot.data!.isNotEmpty) {
//               return ListView.separated(
//                   itemCount: retrievedEmployeeList!.length,
//                   separatorBuilder: (context, index) => const SizedBox(
//                         height: 10,
//                       ),
//                   itemBuilder: (context, index) {
//                     return Container(
//                       decoration: BoxDecoration(
//                           color: const Color.fromARGB(255, 83, 80, 80),
//                           borderRadius: BorderRadius.circular(16.0)),
//                       child: ListTile(
//                         onTap: () {
//                           Navigator.pushNamed(context, "/edit",
//                               arguments: retrievedEmployeeList![index]);
//                         },
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         title: Text(retrievedEmployeeList![index]
//                             .taskDescription
//                             .toString()),
//                         subtitle: Text(
//                             retrievedEmployeeList![index].startDate.toString()),
//                         trailing: const Icon(Icons.arrow_right_sharp),
//                       ),
//                     );
//                   });
//             } else if (snapshot.connectionState == ConnectionState.done &&
//                 retrievedEmployeeList!.isEmpty) {
//               return Center(
//                 child: ListView(
//                   children: const <Widget>[
//                     Align(
//                         alignment: AlignmentDirectional.center,
//                         child: Text('No data available')),
//                   ],
//                 ),
//               );
//             } else {
//               return const Center(child: CircularProgressIndicator());
//             }
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: (() {
//           AppNavigation.navigateTo(context, AppRouteName.addTaskRoute,
//               arguments: AddTaskArguments(
//                 isFromEdit: false,
//               ));
//         }),
//         tooltip: 'add',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
