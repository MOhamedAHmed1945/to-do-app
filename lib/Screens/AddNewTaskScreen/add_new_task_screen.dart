// ignore_for_file: avoid_unnecessary_containers
import 'package:flutter/material.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter_application_to_do/Models/ProviderModels/auth_providers.dart';
import 'package:flutter_application_to_do/ThemeApp/theme_app.dart';
import 'package:provider/provider.dart';
import '../../Models/ProviderModels/list_provider.dart';
import '../../Widgets/custom_item_task.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({Key? key}) : super(key: key);
  static String routeName = 'add new task screen';
  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    var authProvider = Provider.of<AuthProviders>(context);
    if (listProvider.tasksList.isEmpty) {
      listProvider.getAllTasksFromFireStore(authProvider.currentUser!.userId!);
    }
    return Column(
      children: [
        Container(
          child: CalendarTimeline(
            initialDate: listProvider.selectedDate,
            firstDate: DateTime.now().subtract(const Duration(days: 365)),
            lastDate: DateTime.now().add(const Duration(days: 365)),
            onDateSelected: (date) {
              listProvider.changeSelectedDate(
               date, authProvider.currentUser!.userId!);
           },
            leftMargin: 20,
            monthColor: MyThemeApp.blackColor,
            dayColor: MyThemeApp.blackColor,
            activeDayColor: MyThemeApp.whiteColor,
            activeBackgroundDayColor: Colors.redAccent[100],
            dotsColor: const Color(0xFF333a47),
            selectableDayPredicate: (date) => date.day != true, 
            locale: 'en',
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: listProvider.tasksList.length,
            itemBuilder: (context, index) {
              return CustomItemTask(task: listProvider.tasksList[index]);
            },
          ),
        ),
      ],
    );
  }
}