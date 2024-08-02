import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled/extensions/space_exs.dart';
import 'package:untitled/main.dart';
import 'package:untitled/models/task.dart';
import 'package:untitled/utils/app_colors.dart';
import 'package:untitled/utils/constants.dart';
import 'package:untitled/views/home/components/home_app_bar.dart';
import 'package:untitled/views/home/widget/task_widget.dart';
import '../../utils/app_str.dart';
import 'components/fab.dart';
import 'components/slider_drawer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  GlobalKey<SliderDrawerState> drawerKey = GlobalKey<SliderDrawerState>();


  ///Check value for Circle Indicator
  dynamic valueOfIndicator(List<Task> task){
    if(task.isNotEmpty){
      return task.length;
    }
    else{
      return 3;
    }
  }

  ///Check Done tasks
  int checkDoneTasks(List<Task> tasks){
    int i=0;
    for(Task doneTask in tasks){
      if(doneTask.isCompleted){
        i++;
      }
    }
    return i;
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final base = BaseWidget.of(context);
    return ValueListenableBuilder(valueListenable: base.dataStore.listenToTask(), builder: (ctx,Box<Task> box,Widget? child){

      var tasks = box.values.toList();

      ///For sorting the list
      tasks.sort((a,b)=> a.createdAtDate.compareTo(b.createdAtDate));




      return Scaffold(
        backgroundColor: Colors.white,

        ///FAB
        floatingActionButton: const Fab(),

        ///Body
        body: SliderDrawer(
            key: drawerKey,
            isDraggable: false,
            animationDuration: 1000,

            ///Drawer
            slider: CustomDrawer(),
            appBar: HomeAppBar(drawerKey: drawerKey),

            ///Main Body
            child: _buildHomeBody(
                textTheme,
              base,
              tasks
            )),
      );
    });
  }

  ///Home Body
  Widget _buildHomeBody(
      TextTheme textTheme,
      BaseWidget base,
      List<Task> tasks,
      ) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          ///Custom AppBar
          Container(
            width: double.infinity,
            // margin: const EdgeInsets.only(),
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ///Progress Indicator
                 SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    value: checkDoneTasks(tasks)/valueOfIndicator(tasks),
                    backgroundColor: Colors.grey,
                    valueColor: const AlwaysStoppedAnimation(AppColors.primaryColor),
                  ),
                ),

                //Space
                25.w,

                ///Top Level Task Info
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStr.mainTitle,
                      style: textTheme.displayLarge,
                    ),
                    4.h,
                    Text(
                        "${checkDoneTasks(tasks)} of ${tasks.length} task"
                    ),
                  ],
                ),
              ],
            ),
          ),

          ///Divider
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Divider(
              thickness: 3,
              indent: 90,
            ),
          ),

          //Tasks
          SizedBox(
            width: double.infinity,
            height: 500,
            child: tasks.isNotEmpty

                ///Task List is Not empty
                ? ListView.builder(
                    itemCount: tasks.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {

                      ///Get single task for showing
                      var task = tasks[index];
                      return Dismissible(
                        direction: DismissDirection.horizontal,
                        onDismissed: (_) {
                          base.dataStore.deleteTask(task: task);
                        },
                        background: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.delete_outline,
                              color: Colors.grey,
                            ),
                            8.w,
                            const Text(
                              AppStr.deletedTask,
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        key: Key(task.id),
                        child: TaskWidget(task: task,),
                      );
                    },
                  )

                ///Task List is empty
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ///Lottie Animation
                      FadeIn(
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: Lottie.asset(
                            lottieURL,
                            animate: true,
                          ),
                        ),
                      ),

                      ///Sub Text
                      FadeInUp(
                        from: 30,
                        child: const Text(AppStr.doneAllTask),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
