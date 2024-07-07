// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables, use_build_context_synchronously, unnecessary_string_interpolations
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_to_do/Screens/AuthScreens/register_screen.dart';
import 'package:flutter_application_to_do/FireBaseUtils/fire_base_utils.dart';
import 'package:provider/provider.dart';
import '../../Models/ProviderModels/auth_providers.dart';
import '../home_screen.dart';
import '../../ThemeApp/theme_app.dart';
import '../../Widgets/AuthWidgets/custom_text_form_field.dart';
import '../../Widgets/DialogUtils/custom_dialog_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});
  static String routeName = 'login screen';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController =
      TextEditingController(text: 'mohamed@gmail.com');

  TextEditingController passwordController =
      TextEditingController(text: '2532001');

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: MyThemeApp.backgroundLigtColor,
          child: Image.asset(
            'lib/Assets/Images/background.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title:  Text(AppLocalizations.of(context)!.app_title_loin),
            centerTitle: true,
            backgroundColor: Colors.transparent,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.25,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                           AppLocalizations.of(context)!.welocme_massage,// 'Welcome Back !',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        CustomTextFormField(
                          label:AppLocalizations.of(context)!.email,// 'Email',
                          keyBoradType: TextInputType.emailAddress,
                          controller: emailController,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Please Enter Email';
                            }
                            final bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(text);
                            if (!emailValid) {
                              return 'Please Enter Valid Email';
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          label:AppLocalizations.of(context)!.password,// 'Password',
                          keyBoradType: TextInputType.number,
                          controller: passwordController,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Please Enter Password';
                            }
                            if (text.length < 6) {
                              return 'Password should be at least 6 chars. ';
                            }
                            return null;
                          },
                          obscureText: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ElevatedButton(
                            onPressed: () {
                              login();
                            },
                            child: Text(
                              AppLocalizations.of(context)!.login,//'Loin',
                              style: MyThemeApp.lightTheme.textTheme.titleLarge,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacementNamed(
                                  RegisterScreen.routeName);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.or_create_account,
                             // 'Or Create Account!',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    color: MyThemeApp.primaryColor,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void login() async {
    if (formKey.currentState!.validate() == true) {
      DialogUtils.showLoading(
        context: context,
        message: AppLocalizations.of(context)!.loading_massage,
        isDismissible: false,
      );
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        var user = await FireBaseUtils.readUserFromFireStore(
            credential.user?.uid ?? '');
        if (user == null) {
          return;
        }
        var authProvider = Provider.of<AuthProviders>(context, listen: false);
        authProvider.updateUser(user);
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(
            context: context,
            message: AppLocalizations.of(context)!.login_sacsessfuly_massage,
            title: AppLocalizations.of(context)!.sacsess_massage,
            posActionName: AppLocalizations.of(context)!.ok_massage,
            posAction: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            context: context,
            message:
                'The Supplied Auth Credential Is Incorrect,Maliformed Or Has Expired',
            title: 'Error',
            posActionName: 'OK',
          );
        } else if (e.code == 'wrong-password') {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            context: context,
            message: 'Wrong Password',
            title: 'Error',
            posActionName: AppLocalizations.of(context)!.ok_massage,
          );
        }
      } catch (e) {
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(
          context: context,
          message: '${e.toString()}',
          title: 'Error',
          posActionName: AppLocalizations.of(context)!.ok_massage,
        );
      }
    }
  }
}
