import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../Models/ProviderModels/app_config_Provider.dart';
import '../ThemeApp/theme_app.dart';

class CustomModeButtomSheet extends StatefulWidget {
  const CustomModeButtomSheet({super.key});
  @override
  State<CustomModeButtomSheet> createState() => _CustomModeButtomSheetState();
}

class _CustomModeButtomSheetState extends State<CustomModeButtomSheet> {
  late AppConfigProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppConfigProvider>(context);
    return Container(
      margin: EdgeInsets.all(12.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        InkWell(
            onTap: () {
              provider.changeTheme(ThemeMode.dark);
            },
            child: provider.appTheme == ThemeMode.dark
                ? getSelectedItemWidget(
                    AppLocalizations.of(context)!.dark,
                  )
                : getUnSelectedItemWidget(
                    AppLocalizations.of(context)!.dark,
                  )),
        SizedBox(
          height: 15.0,
        ),
        InkWell(
            onTap: () {
              provider.changeTheme(ThemeMode.light);
            },
            child: provider.appTheme == ThemeMode.light
                ? getSelectedItemWidget(
                    AppLocalizations.of(context)!.light,
                  )
                : getUnSelectedItemWidget(
                    AppLocalizations.of(context)!.light,
                  )),
      ]),
    );
  }

  Widget getSelectedItemWidget(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text,
            style: provider.appTheme == ThemeMode.dark
                ? Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: MyThemeApp.primaryColor,
                      //fontWeight: FontWeight.bold,
                    )
                : Theme.of(context).textTheme.titleSmall),
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
