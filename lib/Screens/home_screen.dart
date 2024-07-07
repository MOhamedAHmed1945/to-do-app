// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_application_to_do/Screens/AuthScreens/login_screen.dart';
import 'package:flutter_application_to_do/Screens/SettingsScreen/settings_screen.dart';
import 'package:provider/provider.dart';
import '../Models/ProviderModels/auth_providers.dart';
import '../Models/ProviderModels/list_provider.dart';
import '../Widgets/custom_add_task_bottom_sheet.dart';
import 'AddNewTaskScreen/add_new_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String routeName = 'homeScreen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProviders>(context);
    var listProvider = Provider.of<ListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.15,
        title: Text('To Do List{${authProvider.currentUser!.userName}}',
            style: Theme.of(context).appBarTheme.titleTextStyle),
        actions: [
          IconButton(
            onPressed: () {
              listProvider.tasksList = [];
              authProvider.currentUser = null;
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (index) {
              selectedIndex = index;
              setState(() {});
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.list,
                  ),
                  label: "Task List"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                  ),
                  label: "Settings"),
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddBottomSheet();
        },
        child: const Icon(
          Icons.add,
          size: 35,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: selectedIndex == 0 ? const AddNewTaskScreen() : SettingsScreen(),
    );
  }

  void showAddBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) => const CustomAddTaskBottomSheet());
  }
}
