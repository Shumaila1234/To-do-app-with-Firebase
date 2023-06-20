import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todofirebase/firebase/todo_firebase_crud.dart';
import 'package:todofirebase/firebase/todo_firebase_crud.dart';
import 'package:todofirebase/firebase/todo_firebase_crud1.dart';
import 'package:todofirebase/model/todo.dart';
import 'package:todofirebase/model/todo.dart';
import 'package:todofirebase/custom_widgets/custom_appbar.dart';
import 'package:todofirebase/custom_widgets/custom_button.dart';
import 'package:todofirebase/custom_widgets/custom_text.dart';
import 'package:todofirebase/custom_widgets/textfield.dart';
import 'package:todofirebase/utils/app_colors.dart';
import 'package:todofirebase/utils/app_padding.dart';
import 'package:todofirebase/utils/app_strings.dart';
import 'package:todofirebase/utils/constants.dart';
import 'package:todofirebase/utils/custom_sizedbox.dart';
import 'package:todofirebase/utils/field_validators.dart';
import 'package:todofirebase/utils/time_constants.dart';

class AddTask extends StatefulWidget {
  final bool? isFromEdit;
  final String? taskTitle;
  final String? taskDate;
  final String? taskTime;
  final String? taskId;
  const AddTask(
      {super.key,
      this.isFromEdit,
      this.taskTitle,
      this.taskDate,
      this.taskTime,
      this.taskId});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController _taskTitleController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final _createTaskFormKey = GlobalKey<FormState>();
  bool? isLoading = false;
  DatabaseService service = DatabaseService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.isFromEdit == true) {
      setDefaultData();
    }
  }

  setDefaultData() {
    setState(() {
      _taskTitleController.text = widget.taskTitle ?? "";
      _startDateController.text = widget.taskDate ?? "";
      _startTimeController.text = widget.taskTime ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarWidget(),
      body: SingleChildScrollView(
          child: Form(
        key: _createTaskFormKey,
        child: Padding(
          padding: const EdgeInsets.only(
              top: AppPadding.screenPaddingTop,
              left: AppPadding.screenPaddingLeft,
              right: AppPadding.screenPaddingRight),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              taskTitleField(),
              sizedBox10(),
              dueDateTxt(),
              sizedBox10(),
              _dateTextField(),
              sizedBox10(),
              _timeTextField(_startTimeController),
              sizedBox20(),
              sizedBox10(),
              _addTaskBtn(context)
            ],
          ),
        ),
      )),
    );
  }

  customAppBarWidget() {
    return customAppBar(
        text:
            widget.isFromEdit == true ? AppString.editTask : AppString.addTask);
  }

  dueDateTxt() {
    return const CustomText(
      text: AppString.dueDate,
      fontColor: AppColors.primaryColor,
      fontSize: AppPadding.appTextHeadingFontSize,
    );
  }

  CustomTextfield taskTitleField() {
    return CustomTextfield(
      hintText: AppString.taskFieldHintTxt,
      keyboardType: TextInputType.text,
      isPasswordField: false,
      controller: _taskTitleController,
      isSuffixIcon: true,
      isPrefixIcon: false,
      validator: (value) => value?.validateEmpty(AppString.titleReq),
    );
  }

  CustomTextfield _dateTextField() {
    return CustomTextfield(
      hintText: AppString.startDate,
      keyboardType: TextInputType.text,
      controller: _startDateController,
      isSuffixIcon: true,
      isPrefixIcon: false,
      isReadOnly: true,
      validator: (value) => value?.validateEmpty(AppString.date),
      suffixIcon: InkWell(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            _showDatePicker(_startDateController);
          },
          child: const Icon(
            Icons.calendar_month,
            color: AppColors.primaryColor,
            size: 35,
          )),
      onTap: () {
        _showDatePicker(_startDateController);
      },
    );
  }

  CustomTextfield _timeTextField(
    TextEditingController? textEditingController,
  ) {
    return CustomTextfield(
      hintText: AppString.startTime,
      isPrefixIcon: false,
      keyboardType: TextInputType.text,
      controller: textEditingController,
      isReadOnly: true,
      isSuffixIcon: true,
      validator: (value) => value?.validateEmpty(AppString.time),
      suffixIcon: InkWell(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            _showTimePicker(textEditingController);
          },
          child: const Icon(
            Icons.timer_outlined,
            size: 35,
            color: AppColors.primaryColor,
          )),
      onTap: () {
        _showTimePicker(textEditingController);
      },
    );
  }

  CustomButton _addTaskBtn(BuildContext context) {
    return CustomButton(
      isloading: isLoading == true ? true : false,
      onTap: () {
        if (_createTaskFormKey.currentState!.validate()) {
          if (widget.isFromEdit == true) {
            _updateTaskMethod();
          } else {
            _addTaskMethod();
          }
        }
      },
      horizontalPadding: 0,
      title: widget.isFromEdit == true ? AppString.editTask : AppString.addTask,
      containerColor: AppColors.primaryColor,
    );
  }

  _addTaskMethod() async {
    // var response = await FirebaseCrud.addTodo(
    //   task: _taskTitleController.text,
    //   startDate: _startDateController.text,
    //   startTime: _startTimeController.text,
    // );
    // if (response.code != 200) {
    //   Utils.showSnackBar(
    //     context,
    //     response.message.toString(),
    //   );
    // } else {
    //   Utils.showSnackBar(
    //     context,
    //     response.message.toString(),
    //   );
    // }

    Todo employee = Todo(
        taskDescription: _taskTitleController.text,
        startDate: _startDateController.text,
        startTime: _startTimeController.text);
    setState(() {
      isLoading = true;
    });
    var response = await service.addTodo(employee);
    if (response.code != 200) {
      Utils.showSnackBar(
        context,
        response.message.toString(),
      );
    } else {
      Utils.showSnackBar(
        context,
        response.message.toString(),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  _updateTaskMethod() async {
    Todo employee = Todo(
        id: widget.taskId,
        taskDescription: _taskTitleController.text,
        startDate: _startDateController.text,
        startTime: _startTimeController.text);
    setState(() {
      isLoading = true;
    });
    await service.updateTodo(employee);
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _showDatePicker(TextEditingController? textEditingController) {
    return Constants.showSelectDatePicker(
        context: context,
        getSelectedDate: (v) {
          setState(() {
            _startDateController.text = v.toString();
          });
        });
  }

  Future<void> _showTimePicker(TextEditingController? textEditingController) {
    return Constants.showSelectTimePicker(
        context: context,
        getSelectedDate: (v) {
          log("v  ${v}");
          setState(() {
            _startTimeController.text = v.toString();
          });
        });
  }
}
