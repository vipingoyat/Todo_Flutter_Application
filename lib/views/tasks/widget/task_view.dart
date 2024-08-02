import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:intl/intl.dart';
import 'package:untitled/extensions/space_exs.dart';
import 'package:untitled/utils/app_colors.dart';
import 'package:untitled/utils/app_str.dart';
import 'package:untitled/utils/constants.dart';
import 'package:untitled/views/tasks/widget/task_view_app_bar.dart';
import '../../../main.dart';
import '../../../models/task.dart';
import '../components/date_time_selection.dart';
import '../components/rep_textfield.dart';


class TaskView extends StatefulWidget {
  const TaskView(
      {super.key,
      required this.titleTaskController,
      required this.descriptionTaskController,
      required this.task});

  final TextEditingController? titleTaskController;
  final TextEditingController? descriptionTaskController;
  final Task? task;

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {


  /// Show Selected Time As String Format
  String showTime(DateTime? time) {
    if (widget.task?.createAtTime == null) {
      if (time == null) {
        return DateFormat('hh:mm a').format(DateTime.now()).toString();
      } else {
        return DateFormat('hh:mm a').format(time).toString();
      }
    } else {
      return DateFormat('hh:mm a')
          .format(widget.task!.createAtTime)
          .toString();
    }
  }

  /// Show Selected Date As String Format
  String showDate(DateTime? date) {
    if (widget.task?.createdAtDate == null) {
      if (date == null) {
        return DateFormat.yMMMEd().format(DateTime.now()).toString();
      } else {
        return DateFormat.yMMMEd().format(date).toString();
      }
    } else {
      return DateFormat.yMMMEd().format(widget.task!.createdAtDate).toString();
    }
  }

  // Show Selected Date As DateTime Format
  DateTime showDateAsDateTime(DateTime? date) {
    if (widget.task?.createdAtDate == null) {
      if (date == null) {
        return DateTime.now();
      } else {
        return date;
      }
    } else {
      return widget.task!.createdAtDate;
    }
  }


  /// If any task already exist app will update it otherwise the app will add a new task
  dynamic isTaskAlreadyExistUpdateTaskOtherwiseCreate() {
    ///Here we update the current task
    if (widget.titleTaskController?.text != null &&
        widget.descriptionTaskController?.text != null) {
      try {
        widget.titleTaskController?.text = title;
        widget.descriptionTaskController?.text = subtitle;

        // widget.task?.createdAtDate = date!;
        // widget.task?.createdAtTime = time!;

        widget.task?.save();
        Navigator.of(context).pop();
      } catch (error) {
        updateTaskWarning(context);
      }

      ///Here we create a new Task
    } else {
      if (title != null && subtitle != null) {
        var task = Task.create(
          title: title,
          createdAtTime: time,
          createdAtDate: date,
          subtitle: subtitle,
        );

        ///we adding this new task to Hive DB using inherited widget
        BaseWidget.of(context).dataStore.addTask(task: task);
        Navigator.of(context).pop();
      } else {
        emptyWarning(context);
      }
    }
  }

  ///Delete Task
  /// Delete Selected Task
  dynamic deleteTask() {
    return widget.task?.delete();
  }




  var title;
  var subtitle;
  DateTime? time;
  DateTime? date;


  /// If any Task Already exist return TRUE otherWise FALSE
  bool isTaskAlreadyExistBool() {
    if (widget.titleTaskController?.text == null &&
        widget.descriptionTaskController?.text == null) {
      return true;
    } else {
      return false;
    }
  }



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
        mainAxisAlignment: isTaskAlreadyExistBool()?
        MainAxisAlignment.center: MainAxisAlignment.spaceEvenly,
        children: [
          isTaskAlreadyExistBool()? Container():
          /// Delete Current Task Button
          MaterialButton(
            onPressed: () {
              deleteTask();
              Navigator.pop(context);
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
              isTaskAlreadyExistUpdateTaskOtherwiseCreate();
            },
            minWidth: 150,
            elevation: 10,
            color: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            height: 55,
            child: Text(
              isTaskAlreadyExistBool() ?
              AppStr.addNewTask: AppStr.updateTaskString,
              style: const TextStyle(color: Colors.white),
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
          RepTextField(controller: widget.titleTaskController,
            onFieldSubmitted: (String inputTitle) {
            title = inputTitle;
            },
            onChanged: (String inputTitle) {
              title = inputTitle;
            },
          ),
          10.h,

          ///Task Description
          RepTextField(
            controller: widget.descriptionTaskController,
            isForDescription: true,
            onFieldSubmitted: (String inputSubtitle) {
              subtitle = inputSubtitle;
            },
            onChanged: (String inputSubtitle) {
              subtitle = inputSubtitle;
            },
          ),

          ///Time Selection
          DateTimeSelectionWidget(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => SizedBox(
                  height: 280,
                  child: TimePickerWidget(
                    initDateTime: showDateAsDateTime(time),
                    onChange: (_, __) {},
                    dateFormat: 'HH:mm',
                    onConfirm: (dateTime, _) {
                      setState(() {
                        if(widget.task?.createAtTime == null){
                          time = dateTime;
                        }
                        else{
                          widget.task!.createAtTime==dateTime;
                        }
                      });
                    },
                  ),
                ),
              );
            },
            title: AppStr.timeString,
            time: showTime(time),
          ),

          ///Date Selection
          DateTimeSelectionWidget(
            onTap: () {
              DatePicker.showDatePicker(
                context,
                maxDateTime: DateTime(2029, 12, 30),
                minDateTime: DateTime.now(),

                initialDateTime: showDateAsDateTime(date),
                onConfirm: (dateTime, _) {
                  ///Will complete later
                  setState(() {
                    if(widget.task?.createdAtDate == null){
                      date = dateTime;
                    }
                    else{
                      widget.task!.createdAtDate==dateTime;
                    }
                  });
                },
              );
            },
            title: AppStr.dateString,
            isTime: true,
            time: showDate(date),
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
            text: isTaskAlreadyExistBool()?
            AppStr.addNewTask:AppStr.updateCurrentTask,
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
