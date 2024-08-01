import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled/extensions/space_exs.dart';
import 'package:untitled/utils/app_colors.dart';
import 'package:untitled/utils/constants.dart';
import 'package:untitled/views/home/widget/task_widget.dart';
import '../../utils/app_str.dart';
import 'components/fab.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  final List<int> testing = [2, 67, 8];

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,

      //FAB
      floatingActionButton: const Fab(),


      //Body

      body: _buildHomeBody(textTheme),
    );
  }


  //Home Body
  Widget _buildHomeBody(TextTheme textTheme) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [


          //Custom AppBar
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 70),
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [


                //Progress Indicator
                const SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    value: 1 / 3,
                    backgroundColor: Colors.grey,
                    valueColor:
                    AlwaysStoppedAnimation(AppColors.primaryColor),
                  ),
                ),

                //Space
                25.w,


                //Top Level Task Info


                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStr.mainTitle,
                      style: textTheme.displayLarge,
                    ),
                    4.h,
                    const Text("1 of 3 task"),
                  ],
                ),
              ],
            ),
          ),


          //Divider

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
            height:446,
            child: testing.isNotEmpty



            //Task List is Not empty

                ? ListView.builder(
              itemCount: testing.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Dismissible(
                  direction: DismissDirection.horizontal,
                  onDismissed: (_) {
                    setState(() {
                      testing.removeAt(index);
                    });
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
                  key: Key(testing[index].toString()),
                  child: const TaskWidget(),
                );
              },
            )

            //Task List is empty
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                //Lottie Animation
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

                //Sub Text
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
