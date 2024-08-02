import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({super.key, required this.drawerKey});

  final GlobalKey<SliderDrawerState> drawerKey;

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> with SingleTickerProviderStateMixin{
  late AnimationController animeController;
  bool isDrawerOpen = false;

  @override
  void initState() {
    animeController = AnimationController(vsync: this,
    duration: const Duration(milliseconds: 600),
    );
    super.initState();
  }

  @override
  void dispose() {
    animeController.dispose();
    super.dispose();
  }

  //OnToggle
  void onDrawerToggle(){
    setState(() {
      isDrawerOpen = !isDrawerOpen;
      if(isDrawerOpen){
        animeController.forward();
        widget.drawerKey.currentState!.openSlider();
      }
      else{
        animeController.reverse();
        widget.drawerKey.currentState!.closeSlider();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 130,
      child: Padding(
        padding: const EdgeInsets.only(top: 30,left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            //Menu Icon
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: IconButton(
                onPressed : onDrawerToggle,
                icon: AnimatedIcon(
                  icon: AnimatedIcons.menu_close,
                  progress: animeController,
                  size: 40,
                ),
              ),
            ),

            //Trash Icon
            Padding(
              padding: const EdgeInsets.only(right: 15,top: 10),
              child: IconButton(
                onPressed : (){
                  //TODO: We Will Remove All the Task from DB With This Button
                },
                icon: const Icon(
                  CupertinoIcons.trash,
                  color: Colors.black,
                  size: 40,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
