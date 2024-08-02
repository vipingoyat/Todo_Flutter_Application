import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:untitled/extensions/space_exs.dart';
import 'package:untitled/utils/app_colors.dart';
import 'package:untitled/utils/app_str.dart';
import 'package:untitled/views/tasks/widget/task_view_app_bar.dart';
import '../../../models/task.dart';
import '../components/date_time_selection.dart';
import '../components/rep_textfield.dart';

class TaskView extends StatefulWidget {
  const TaskView({
    super.key,
     this.titleTaskController,
     this.descriptionTaskController,
    required this.task
  });


  final TextEditingController? titleTaskController;
   final TextEditingController? descriptionTaskController;
   final Task? task;


  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        ///App Bar
        appBar: const TaskViewAppBar(),

        ///Body
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ///Top Side Texts
                _buildTopSideTexts(textTheme),

                _buildMainTaskViewActivity(
                  textTheme,
                  context,
                ),

                ///Bottom Side buttons
                _buildBottomSideButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///Bottom Side buttons
  Widget _buildBottomSideButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          /// Delete Current Task Button
          MaterialButton(
            onPressed: () {
              log("Task Has Been Deleted.");
            },
            minWidth: 150,
            elevation: 5,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            height: 55,
            child: Row(
              children: [
                const Icon(
                  Icons.close,
                  color: AppColors.primaryColor,
                ),
                5.w,
                const Text(
                  AppStr.deleteTask,
                  style: TextStyle(color: AppColors.primaryColor),
                ),
              ],
            ),
          ),

          ///Add or Update Task Button
          MaterialButton(
            onPressed: () {
              ///Add or Update Task Activity
              log("New Task Has Been Created.");
            },
            minWidth: 150,
            elevation: 10,
            color: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            height: 55,
            child: const Text(
              AppStr.addNewTask,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  ///Main Task View Activity
  Widget _buildMainTaskViewActivity(TextTheme textTheme, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 530,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///Title of TextField
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              AppStr.titleOfTitleTextField,
              style: textTheme.headlineMedium,
            ),
          ),

          ///Task Title
          RepTextField(controller: widget.titleTaskController),
          10.h,

          ///Task Description
          RepTextField(
            controller: widget.descriptionTaskController,
            isForDescription: true,
          ),

          ///Time Selection
          DateTimeSelectionWidget(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => SizedBox(
                  height: 280,
                  child: TimePickerWidget(
                    // initDateTime
                    onChange: (_, __) {},
                    dateFormat: 'HH:mm',
                    onConfirm: (dateTime, _) {},
                  ),
                ),
              );
            },
            title: AppStr.timeString,
          ),

          ///Date Selection
          DateTimeSelectionWidget(
            onTap: () {
              DatePicker.showDatePicker(
                context,
                maxDateTime: DateTime(2029, 12, 30),
                minDateTime: DateTime.now(),

                //Initial Date and Time
                onConfirm: (dateTime, _) {
                  ///Will complete later
                },
              );
            },
            title: AppStr.dateString,
          ),
        ],
      ),
    );
  }

  ///Top Side Texts
  Widget _buildTopSideTexts(TextTheme textTheme) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ///DIVIDER GREY
          const SizedBox(
            width: 70,
            child: Divider(
              thickness: 2,
            ),
          ),

          ///Later on According to task condition
          ///we will decide to Add New Task or Update Current
          ///Task

          RichText(
              text: TextSpan(
            text: AppStr.addNewTask,
            style: textTheme.titleLarge,
            children: const [
              TextSpan(
                  text: AppStr.taskStrnig,
                  style: TextStyle(fontWeight: FontWeight.w400))
            ],
          )),
          const SizedBox(
            width: 70,
            child: Divider(
              thickness: 2,
            ),
          ),
        ],
      ),
    );
  }
}
