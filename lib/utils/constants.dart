import 'package:flutter/cupertino.dart';
import 'package:ftoast/ftoast.dart';
import 'package:untitled/main.dart';
import 'app_str.dart';
import 'package:panara_dialogs/panara_dialogs.dart';


String lottieURL = 'assets/lottie/1.json';


///Empty  Title OR SubTitle TextField warning
dynamic emptyWarning(BuildContext context) {
  return FToast.toast(
      context,
      msg: AppStr.oopsMsg,
      subMsg: 'You Must Fill All the Fields!',
    corner: 20.0,
    duration: 2000,
    padding: const EdgeInsets.all(20),
  );
}


///Nothing Entered when user tried to enter or update the current task
dynamic updateTaskWarning(BuildContext context) {
  return FToast.toast(
    context,
    msg: AppStr.oopsMsg,
    subMsg: 'You Must Fill All the Fields!',
    corner: 20.0,
    duration: 5000,
    padding: const EdgeInsets.all(20),
  );
}

///No task warning for deleting
dynamic noTaskWarning(BuildContext context) {
  return PanaraInfoDialog.showAnimatedGrow(
      context,
      title: AppStr.oopsMsg,
      message: "There is no Task For Delete!\n Try adding some and then try to delete it!",
      buttonText: "Okay",
      onTapDismiss: (){Navigator.pop(context);},
      panaraDialogType: PanaraDialogType.warning,
  );
}


///Delete all the Task from DB
dynamic deleteAllTask(BuildContext context) {
  return PanaraConfirmDialog.show(
    context,
    title: AppStr.areYouSure,
    message: "Do You really want to delete all tasks? You will no be able to undo this action!",
    confirmButtonText: 'Yes',
    cancelButtonText: "No",
    onTapCancel: (){
      Navigator.pop(context);
    },
    onTapConfirm: (){

      ///Clearing All the Data from the Box using this command
      BaseWidget.of(context).dataStore.box.clear();
      Navigator.pop(context);
    },
    panaraDialogType: PanaraDialogType.error,
    barrierDismissible: false,
  );
}

