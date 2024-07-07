import 'package:flutter/material.dart';
import 'package:flutter_application_to_do/FireBaseUtils/fire_base_utils.dart';
import 'package:flutter_application_to_do/Models/task_model.dart';
import 'package:flutter_application_to_do/ThemeApp/theme_app.dart';
import 'package:flutter_application_to_do/Widgets/DialogUtils/custom_dialog_utils.dart';
import 'package:provider/provider.dart';
import '../Models/ProviderModels/app_config_Provider.dart';
import '../Models/ProviderModels/auth_providers.dart';
import '../Models/ProviderModels/list_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomAddTaskBottomSheet extends StatefulWidget {
  const CustomAddTaskBottomSheet({super.key});
  @override
  State<CustomAddTaskBottomSheet> createState() =>
      _CustomAddTaskBottomSheetState();
}

class _CustomAddTaskBottomSheetState extends State<CustomAddTaskBottomSheet> {
  var selectedDate = DateTime.now();
  var formKey = GlobalKey<FormState>();
  String title = '';
  String decoration = '';
  late ListProvider listProvider;
  late AuthProviders authProvider;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    listProvider = Provider.of<ListProvider>(context);
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(children: [
        Text(
          AppLocalizations.of(context)!.add_new_task, //'Add New Task ',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                onChanged: (text) {
                  title = text;
                },
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!
                      .enter_task_title, // 'Enter Task Title',
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please Enter Task Title';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                onChanged: (text) {
                  decoration = text;
                },
                decoration: InputDecoration(
                  hintText:
                      AppLocalizations.of(context)!.enter_task_description,
                ),
                maxLines: 4,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please Enter Task Description';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                AppLocalizations.of(context)!.select_date, // 'Select Date',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 10.0,
              ),
              InkWell(
                onTap: () {
                  showCalende();
                },
                child: Text(
                  '${selectedDate.day} /${selectedDate.month}/ ${selectedDate.year}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
                onPressed: () {
                  addTaskFun();
                },
                child: Text(AppLocalizations.of(context)!.add_button, //'Add',
                    style: MyThemeApp.lightTheme.textTheme.titleLarge),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  void showCalende() async {
    var chosenDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(
          days: 365,
        ),
      ),
    );
    if (chosenDate != null) {
      selectedDate = chosenDate;
    }
    setState(() {});
  }

  void addTaskFun() async {
    authProvider = Provider.of<AuthProviders>(context, listen: false);
    DialogUtils.showLoading(context: context, message: 'Loading....');

    if (formKey.currentState?.validate() == true) {
      TaskModel task = TaskModel(
        titleTask: title,
        descriptionTask: decoration,
        dateTask: selectedDate,
      );
      FireBaseUtils.addTaskToFireStore(task, authProvider.currentUser!.userId!)
          .then((value) {
        if (mounted) {
          Navigator.pop(context);
          print('Task Added Successfully');
          // DialogUtils.showMessage(
          //   context: context,
          //   message: 'Task Added Successfully',
          //   nagActionName: 'OK',
          //   nagAction: () {
          //     if (mounted) {
          //       Navigator.pop(context);
          //     }
          //   },
          // );
          listProvider
              .getAllTasksFromFireStore(authProvider.currentUser!.userId!);
        }
      }).timeout(
        const Duration(milliseconds: 500),
        onTimeout: () {
          if (mounted) {
            print('Task added successfully');
            listProvider
                .getAllTasksFromFireStore(authProvider.currentUser!.userId!);
            Navigator.pop(context);
          }
        },
      );
    }
  }
}
