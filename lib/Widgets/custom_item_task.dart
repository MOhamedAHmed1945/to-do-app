// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_application_to_do/Models/task_model.dart';
import 'package:flutter_application_to_do/ThemeApp/theme_app.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../FireBaseUtils/fire_base_utils.dart';
import '../Models/ProviderModels/auth_providers.dart';
import '../Models/ProviderModels/list_provider.dart';
import '../Screens/EditTaskScreen/edit_task_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomItemTask extends StatefulWidget {
  CustomItemTask({Key? key, required this.task}) : super(key: key);
  TaskModel task;
  @override
  State<CustomItemTask> createState() => _CustomItemTaskState();
}

class _CustomItemTaskState extends State<CustomItemTask> {
  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    var authProvider = Provider.of<AuthProviders>(context);
    var uId = authProvider.currentUser!.userId!;
    return Container(
      margin: const EdgeInsets.all(12),
      child: Slidable(
        key: UniqueKey(),
        startActionPane: ActionPane(
          extentRatio: 0.45,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(12),
              onPressed: (context) {
                FireBaseUtils.deleteTaskFromFireStore(widget.task, uId)
                    .then((value) {
                  //aleart massages
                  // DialogUtils.showMessage(
                  //     context: context,
                  //     message: 'Task Delete Successfully',
                  //     posActionName: 'OK',
                  //     posAction: () {
                  //       Navigator.pop(context);
                  //     });
                  print('task added sucsess');
                  listProvider.getAllTasksFromFireStore(uId);
                  // Navigator.pop(context);
                }).timeout(const Duration(milliseconds: 500), onTimeout: () {
                  print("delete task successfully");
                  listProvider.getAllTasksFromFireStore(uId);
                });
              },
              backgroundColor: MyThemeApp.redColor,
              foregroundColor: MyThemeApp.whiteColor,
              icon: Icons.delete,
              label: AppLocalizations.of(context)!.delete_button, // 'Delete',
            ),
            SlidableAction(
              borderRadius: BorderRadius.circular(12),
              onPressed: (context) {
                Navigator.of(context).pushNamed(
                  EditTaskScreen.routeName,
                  arguments: CustomItemTask(task: widget.task),
                );
              },
              backgroundColor: MyThemeApp.blueLigtColor,
              foregroundColor: MyThemeApp.whiteColor,
              icon: Icons.delete,
              label: AppLocalizations.of(context)!.edit_button, //'Edit',
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: MyThemeApp.whiteColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.10,
                width: 4,
                color: widget.task.isDoneTask!
                    ? MyThemeApp.greenColor
                    : MyThemeApp.primaryColor,
                //MyThemeApp.primaryColor,
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.task.titleTask ?? '',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: widget.task.isDoneTask!
                              ? MyThemeApp.greenColor
                              : MyThemeApp.primaryColor),
                    ),
                    Text(
                      widget.task.descriptionTask ?? '',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  FireBaseUtils.editIsDoneTaskFromFireStore(uId, widget.task);
                  widget.task.isDoneTask = !widget.task.isDoneTask!;
                  setState(() {});
                },
                child: widget.task.isDoneTask!
                    ? Text(
                        'Done !',
                        style: TextStyle(
                          color: MyThemeApp.greenColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 21),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: MyThemeApp.primaryColor,
                        ),
                        child: Icon(
                          Icons.check,
                          color: MyThemeApp.whiteColor,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
