import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../Models/ProviderModels/app_config_Provider.dart';
import '../../ThemeApp/theme_app.dart';
import '../../Widgets/custom_language_buttom_sheet.dart';
import '../../Widgets/custom_mode_buttom_sheet.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  static String routeName = 'settingsScreen';
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      margin: const EdgeInsets.all(15.0),
      child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
        Text(
          AppLocalizations.of(context)!.language,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: 15.0,
        ),
        InkWell(
          onTap: () {
            showLanguageButtomSheet();
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: MyThemeApp.primaryColor,
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  provider.appLanguage == 'en'
                      ? AppLocalizations.of(context)!.english
                      : AppLocalizations.of(context)!.arabic,
                  // AppLocalizations.of(context)!.english,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const Icon(
                  Icons.arrow_drop_down,
                  size: 30.0,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 32.0,
        ),
        Text(
          AppLocalizations.of(context)!.theme,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: 15.0,
        ),
        InkWell(
          onTap: () {
            showModeButtomSheet();
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: MyThemeApp.primaryColor,
                borderRadius: BorderRadius.circular(12),),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  // AppLocalizations.of(context)!.light,
                  provider.appTheme == ThemeMode.dark
                      ? AppLocalizations.of(context)!.dark
                      : AppLocalizations.of(context)!.light,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const Icon(
                  Icons.arrow_drop_down,
                  size: 30.0,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  void showLanguageButtomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const CustomLanguageButtomSheet(),
    );
  }

  void showModeButtomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const CustomModeButtomSheet(),
    );
  }
}
