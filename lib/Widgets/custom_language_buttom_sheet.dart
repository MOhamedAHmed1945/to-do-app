import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../Models/ProviderModels/app_config_Provider.dart';
import '../ThemeApp/theme_app.dart';

class CustomLanguageButtomSheet extends StatefulWidget {
  const CustomLanguageButtomSheet({super.key});

  @override
  State<CustomLanguageButtomSheet> createState() =>
      _CustomLanguageButtomSheetState();
}

class _CustomLanguageButtomSheetState extends State<CustomLanguageButtomSheet> {
  late AppConfigProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppConfigProvider>(context);
    return Container(
      margin: EdgeInsets.all(12.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        InkWell(
            onTap: () {
              provider.changeLanguage('en');
            },
            child: provider.appLanguage == 'en'
                ? getSelectedItemWidget(
                    AppLocalizations.of(context)!.english,
                  )
                : getUnSelectedItemWidget(
                    AppLocalizations.of(context)!.english,
                  )),
        SizedBox(
          height: 15.0,
        ),
        InkWell(
            onTap: () {
              provider.changeLanguage('ar');
            },
            child: provider.appLanguage == 'ar'
                ? getSelectedItemWidget(
                    AppLocalizations.of(context)!.arabic,
                  )
                : getUnSelectedItemWidget(
                    AppLocalizations.of(context)!.arabic,
                  )),
      ]),
    );
  }

  Widget getSelectedItemWidget(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        Icon(
          Icons.check,
          color: Theme.of(context).primaryColor,
          size: 35.0,
        ),
      ],
    );
  }

  Widget getUnSelectedItemWidget(String text) {
    return Text(text,
        style: provider.appTheme == ThemeMode.dark
            ? Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: MyThemeApp.primaryColor,
                  //fontWeight: FontWeight.bold,
                )
            : Theme.of(context).textTheme.titleSmall);
  }
}
