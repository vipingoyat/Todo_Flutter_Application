import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({super.key});

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

  void onDrawerToggle(){
    setState(() {
      isDrawerOpen = !isDrawerOpen;
      if(isDrawerOpen){
        animeController.forward();
      }
      else{
        animeController.reverse();
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
            Padding(
              padding: const EdgeInsets.only(right: 15,top: 10),
              child: IconButton(
                onPressed : onDrawerToggle,
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