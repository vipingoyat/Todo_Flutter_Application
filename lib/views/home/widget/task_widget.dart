import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/task.dart';
import '../../../utils/app_colors.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  // ignore: library_private_types_in_public_api
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  TextEditingController taskControllerForTitle = TextEditingController();
  TextEditingController taskControllerForSubtitle = TextEditingController();

  @override
  void initState() {
    super.initState();
    taskControllerForTitle.text = widget.task.title;
    taskControllerForSubtitle.text = widget.task.subtitle;
  }

  @override
  void dispose() {
    taskControllerForTitle.dispose();
    taskControllerForSubtitle.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //Navigate to task View to see the Details
      },

      ///Main Card
      child: AnimatedContainer(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
              color: widget.task.isCompleted
                  ? const Color.fromARGB(154, 119, 144, 229)
                  : Colors.white,
              borderRadius: BorderRadius.circular(9),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(0, 5),
                    blurRadius: 10)
              ]),
          duration: const Duration(milliseconds: 600),
          child: ListTile(
            ///Check Icon
            leading: GestureDetector(
              onTap: () {
                //Check or UnCheck the Task
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                decoration: BoxDecoration(
                    color: widget.task.isCompleted
                        ? AppColors.primaryColor
                        : Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey, width: .8)),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              ),
            ),

            ///Task Title
            title: Padding(
              padding: const EdgeInsets.only(bottom: 5, top: 3),
              child: Text(
                taskControllerForTitle.text,
                style: TextStyle(
                  color: widget.task.isCompleted
                      ? AppColors.primaryColor
                      : Colors.black,
                  fontWeight: FontWeight.w500,
                  decoration: widget.task.isCompleted
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),
            ),

            ///Task Subtitle -> Description
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  taskControllerForSubtitle.text,
                  style: TextStyle(
                    color: widget.task.isCompleted
                        ? AppColors.primaryColor
                        : Colors.grey.shade600,
                    fontWeight: FontWeight.w300,
                    decoration: widget.task.isCompleted
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),

                ///Date & Time  of Task
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5, top: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('hh:mm a')
                              .format(widget.task.createAtTime),
                          style: TextStyle(
                            fontSize: 14,
                            color: widget.task.isCompleted
                                ? Colors.white
                                : Colors.grey,
                          ),
                        ),
                        Text(
                          DateFormat.yMMMEd().format(widget.task.createdAtDate),
                          style: TextStyle(
                            fontSize: 12,
                            color: widget.task.isCompleted
                                ? Colors.white
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
