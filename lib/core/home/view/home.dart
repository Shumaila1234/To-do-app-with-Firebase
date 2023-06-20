import 'package:flutter/material.dart';
import 'package:todofirebase/core/add_task/arguments/add_task_arguments.dart';
import 'package:todofirebase/custom_widgets/custom_appbar.dart';
import 'package:todofirebase/custom_widgets/custom_text.dart';
import 'package:todofirebase/firebase/todo_firebase_crud1.dart';
import 'package:todofirebase/model/todo.dart';
import 'package:todofirebase/utils/app_colors.dart';
import 'package:todofirebase/utils/app_navigations.dart';
import 'package:todofirebase/utils/app_padding.dart';
import 'package:todofirebase/utils/app_route_name.dart';
import 'package:todofirebase/utils/app_strings.dart';
import 'package:todofirebase/utils/custom_sizedbox.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final Stream<QuerySnapshot> collectionReference = FirebaseCrud.readTodo();
  DatabaseService service = DatabaseService();
  Future<List<Todo>>? employeeList;
  List<Todo>? retrievedEmployeeList;

  @override
  void initState() {
    super.initState();
    _initRetrieval();
  }

  Future<void> _initRetrieval() async {
    employeeList = service.retrieveTodo();
    retrievedEmployeeList = await service.retrieveTodo();
  }

  deleteTodo() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarWidget(),
      body: RefreshIndicator(
        onRefresh: _initRetrieval,
        child: Padding(
            padding: const EdgeInsets.only(
                top: AppPadding.screenPaddingTop,
                left: AppPadding.screenPaddingLeft,
                right: AppPadding.screenPaddingRight),
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                checkoutAnimationTxt(),
                sizedBox10(),
                todayText(),
                sizedBox10(),
                taskStreamList()
              ],
            ))
            // child: taskStreamList(),
            ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppNavigation.navigateTo(context, AppRouteName.addTaskRoute,
              arguments: AddTaskArguments(
                isFromEdit: false,
              ));
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  customAppBarWidget() {
    return customAppBar(text: AppString.todoFirebaseApp);
  }

  todayText() {
    return const CustomText(
      text: AppString.today,
      fontWeight: FontWeight.bold,
      fontSize: AppPadding.homeHeadText,
    );
  }

  checkoutAnimationTxt() {
    return InkWell(
      onTap: (() {
        AppNavigation.navigateTo(context, AppRouteName.animationScreenRoute);
      }),
      child: const CustomText(
        text: AppString.checkoutAnimationTxt,
        fontWeight: FontWeight.bold,
        fontSize: AppPadding.homeHeadText,
      ),
    );
  }

  tommorrowText() {
    return const CustomText(
      text: AppString.tommorrow,
      fontWeight: FontWeight.bold,
      fontSize: AppPadding.homeHeadText,
    );
  }

  thisWeekText() {
    return const CustomText(
      text: AppString.thisWeek,
      fontWeight: FontWeight.bold,
      fontSize: AppPadding.homeHeadText,
    );
  }

  customRowWidget({IconData? icon, String? text}) {
    return Row(
      children: [
        Icon(
          icon ?? Icons.info_outline,
          color: AppColors.primaryColor,
        ),
        CustomText(
          text: " ${text}",
        ),
      ],
    );
  }

  taskStreamList() {
    return RefreshIndicator(
      onRefresh: _initRetrieval,
      child: FutureBuilder(
        future: employeeList,
        builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: retrievedEmployeeList!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: CustomText(
                            textAlign: TextAlign.start,
                            text:
                                "Task: ${retrievedEmployeeList![index].taskDescription.toString()}",
                            // text: "gd",
                          ),
                        ),
                        subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              sizedBox10(),
                              customRowWidget(
                                  icon: Icons.date_range,
                                  text: retrievedEmployeeList![index]
                                      .startDate
                                      .toString()),
                              customRowWidget(
                                  icon: Icons.timer_sharp,
                                  text: retrievedEmployeeList![index]
                                      .startTime
                                      .toString()),
                            ]),
                        trailing: Column(
                          children: [
                            InkWell(
                              onTap: () async {
                                var response = service.deleteTodo(
                                    docId: retrievedEmployeeList![index]
                                        .id
                                        .toString());
                                // Utils.showSnackBar(
                                //   context,
                                //   response.message.toString(),
                                // );
                                // if (response != 200) {
                                //   retrievedEmployeeList!.removeAt(index);
                                // } else {
                                //   Utils.showSnackBar(
                                //     context,
                                //     response.message.toString(),
                                //   );
                                // }
                              },
                              child: const Icon(
                                Icons.delete,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                AppNavigation.navigateTo(
                                    context, AppRouteName.addTaskRoute,
                                    arguments: AddTaskArguments(
                                        isFromEdit: true,
                                        taskTitle: retrievedEmployeeList![index]
                                            .taskDescription
                                            .toString(),
                                        taskDate: retrievedEmployeeList![index]
                                            .startDate
                                            .toString(),
                                        taskTime: retrievedEmployeeList![index]
                                            .startTime
                                            .toString(),
                                        taskId:
                                            retrievedEmployeeList![index].id));
                              },
                              child: const Icon(
                                Icons.edit,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          } else if (snapshot.connectionState == ConnectionState.done &&
              retrievedEmployeeList!.isEmpty) {
            return const Center(
              child: Align(
                  alignment: AlignmentDirectional.center,
                  child: Text('No data available')),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  /*taskStreamList() {
    return StreamBuilder(
      stream: collectionReference,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //if any error occured from firebase
        if (snapshot.hasError) {
          return Center(
            child: CustomText(
              text: "Error ${snapshot.error}",
            ),
          );
        }

        //if data not found.
        if (!snapshot.hasData) {
          return const Center(
            child: CustomText(
              text: AppString.noTasksFound,
            ),
          );
        }

        //if state is in  loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        //if there are task
        if (snapshot.hasData) {
          return ListView(
            shrinkWrap: true,
            children: snapshot.data!.docs.map((e) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(children: [
                      ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: CustomText(
                            textAlign: TextAlign.start,
                            text: "Task: ${e["task"]}",
                            // text: "gd",
                          ),
                        ),
                        subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              sizedBox10(),
                              customRowWidget(
                                  icon: Icons.date_range, text: e["startDate"]),
                              customRowWidget(
                                  icon: Icons.timer_sharp,
                                  text: e["startTime"]),
                            ]),
                        trailing: Column(
                          children: [
                            InkWell(
                              onTap: () async {
                                var response =
                                    await FirebaseCrud.deleteTodo(docId: e.id);
                              },
                              child: const Icon(
                                Icons.delete,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                AppNavigation.navigateTo(
                                    context, AppRouteName.addTaskRoute,
                                    arguments: AddTaskArguments(
                                      isFromEdit: true,
                                      taskTitle: e["task"],
                                      taskDate: e["startDate"],
                                      taskTime: e["startTime"],
                                      taskId: e.id,
                                    ));
                              },
                              child: const Icon(
                                Icons.edit,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ])),
              );
            }).toList(),
          );
        }

        //default
        return Container();
      },
    );
  }*/
}
