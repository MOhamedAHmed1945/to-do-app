// ignore_for_file: prefer_const_constructors, unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_to_do/Models/ProviderModels/auth_providers.dart';
import 'package:flutter_application_to_do/Screens/AuthScreens/login_screen.dart';
import 'package:flutter_application_to_do/ThemeApp/theme_app.dart';
import 'package:provider/provider.dart';
import 'Models/ProviderModels/app_config_Provider.dart';
import 'Screens/AuthScreens/register_screen.dart';
import 'Models/ProviderModels/list_provider.dart';
import 'Screens/AddNewTaskScreen/add_new_task_screen.dart';
import 'Screens/EditTaskScreen/edit_task_screen.dart';
import 'Screens/SettingsScreen/settings_screen.dart';
import 'Screens/TaskDeleteScreen/task_delete_screen.dart';
import 'Screens/TaskDoneScreen/task_done_screen.dart';
import 'Screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // FirebaseFirestore.instance.settings =
  //     Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  // await FirebaseFirestore.instance.disableNetwork();
  runApp(
    MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ListProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => AuthProviders(),
      ),
      ChangeNotifierProvider(
        create: (context) => AppConfigProvider(),
      ),
    ],
    child: MyApp(),
  ));

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: MyThemeApp.lightTheme,

      //darkTheme: MyThemeApp.darkMode,
      themeMode: provider.appTheme,
      darkTheme: MyThemeApp.darkTheme,
      //locale: Locale('ar'),
      locale: Locale(provider.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: LoginScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        TaskDoneScreen.routeName: (context) => TaskDoneScreen(),
        TaskDeleteScreen.routeName: (context) => TaskDeleteScreen(),
        AddNewTaskScreen.routeName: (context) => AddNewTaskScreen(),
        SettingsScreen.routeName: (context) => SettingsScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        EditTaskScreen.routeName: (context) => EditTaskScreen(),
      },
    );
  }
}
//flutter gen-l10n