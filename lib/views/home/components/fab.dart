import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/views/tasks/widget/task_view.dart';
import '../../../utils/app_colors.dart';

class Fab extends StatelessWidget {
  const Fab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ///We will navigate to task View by tapping on this button
        Navigator.push(
            context, CupertinoPageRoute(builder: (_) => TaskView(titleTaskController: null, descriptionTaskController: null,task: null,)));
      },
      child: Material(
        borderRadius: BorderRadius.circular(15),
        elevation: 12,
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(15)),
          child: const Center(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
