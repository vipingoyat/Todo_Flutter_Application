import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:untitled/extensions/space_exs.dart';
import 'package:untitled/utils/app_str.dart';
import 'package:untitled/views/tasks/widget/task_view_app_bar.dart';
import '../components/rep_textfield.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  final TextEditingController titleTaskController = TextEditingController();
  final TextEditingController descriptionTaskController =
      TextEditingController();

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
              ],
            ),
          ),
        ),
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
                    RepTextField(controller: titleTaskController),
                    10.h,

                    ///Task Description
                    RepTextField(
                      controller: descriptionTaskController,
                      isForDescription: true,
                    ),

                    ///Time Selection
                    DateTimeSelectionWidget(
                      onTap: (){
                        showModalBottomSheet(
                            context: context,
                            builder: (_) => SizedBox(
                              height: 280,
                              child: TimePickerWidget(
                                // initDateTime
                                onChange: (_,__){},
                                dateFormat: 'HH:mm',
                                onConfirm: (dateTime,_){
                                },
                              ),
                            ),
                        );
                      }, title: AppStr.timeString,
                    ),


                    ///Date Selection
                    DateTimeSelectionWidget(
                      onTap: (){
                        DatePicker.showDatePicker(
                            context,
                          maxDateTime: DateTime(2029,12,30),
                          minDateTime: DateTime.now(),

                          //Initial Date and Time
                          onConfirm: (dateTime, _){
                              ///Will complete later
                          },
                        );
                      }, title: AppStr.dateString,
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

class DateTimeSelectionWidget extends StatelessWidget {
  const DateTimeSelectionWidget({
    super.key,
    required this.onTap, required this.title,
  });

  final VoidCallback onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(20,20,20,0),
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 13),
                child: Text(
                  title,
                  style: textTheme.headlineSmall,
                )
            ),
            Container(
              margin: const EdgeInsets.only(right: 10),
              width: 80,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade100),
              child: Center(
                ///Text will show date and time as time
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
