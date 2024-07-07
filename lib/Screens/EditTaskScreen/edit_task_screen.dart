// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../FireBaseUtils/fire_base_utils.dart';
import '../../Models/ProviderModels/auth_providers.dart';
import '../../Models/ProviderModels/list_provider.dart';
import '../../Models/task_model.dart';
import '../../Widgets/DialogUtils/custom_dialog_utils.dart';
import '../../Widgets/custom_item_task.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({
    super.key,
  });
  static String routeName = 'edit task screen';
  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late ListProvider listProvider;
  AuthProviders? authProvider;
  late TaskModel taskModel;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late var selectedDate;
  late GlobalKey<FormState> formKey;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final CustomItemTask args =
          ModalRoute.of(context)!.settings.arguments as CustomItemTask;
      // listProvider = Provider.of<ListProvider>(context,listen: false);
      // authProvider = Provider.of<AuthProviders>(context,listen: false);
      taskModel = args.task; // Initialize taskModel
      titleController.text = taskModel.titleTask ?? '';
      descriptionController.text = taskModel.descriptionTask ?? '';
      selectedDate = taskModel.dateTask ?? DateTime.now();
    });

    formKey = GlobalKey<FormState>();
    selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of<ListProvider>(context);
    authProvider = Provider.of<AuthProviders>(context);
    if (authProvider == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.15,
        title: Text('To Do List{${authProvider!.currentUser!.userName}}',
            style: Theme.of(context).appBarTheme.titleTextStyle),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            child: Column(children: [
              Text(
                AppLocalizations.of(context)!.edit_task, //'Edit Task',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!
                            .enter_task_title, //'Enter Task Title',
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
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        hintText: 'Enter Task Description',
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
                      AppLocalizations.of(context)!
                          .select_date, //'Select Date',
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
                        editTaskFun();
                      },
                      child: Text(
                        AppLocalizations.of(context)!
                            .save_change_button, // 'Save Change',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  void showCalende() async {
    var chosenDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(
          days: 365,
        ),
      ),
    );
    if (chosenDate != null) {
      setState(() {
        selectedDate = chosenDate;
      });
    }
  }

  void editTaskFun() async {
    if (authProvider == null) return; // Ensure authProvider is not null
    DialogUtils.showLoading(
        context: context,
        message: AppLocalizations.of(context)!.loading_massage);
    if (formKey.currentState?.validate() == true) {
      taskModel.titleTask = titleController.text;
      taskModel.descriptionTask = descriptionController.text;
      taskModel.dateTask = selectedDate;
      FireBaseUtils.editTaskFromFireStore(
              authProvider!.currentUser!.userId!, taskModel)
          .then((value) {
        if (mounted) {
          Navigator.pop(context);
          print('Task Edited Successfully');
          DialogUtils.showMessage(
            context: context,
            message: 'Task Edit Successfully',
            nagActionName: 'OK',
            nagAction: () {
              if (mounted) {
                // Navigator.pop(context);
              }
            },
          );
        }
      }).timeout(
        const Duration(milliseconds: 500),
        onTimeout: () {
          if (mounted) {
            print('Task edited successfully');
            listProvider
                .getAllTasksFromFireStore(authProvider!.currentUser!.userId!);
            Navigator.pop(context);
          }
        },
      );
    }
  }
}
