// ignore_for_file: must_be_immutable, use_build_context_synchronously, unnecessary_string_interpolations, curly_braces_in_flow_control_structures
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_to_do/Screens/AuthScreens/login_screen.dart';
import 'package:flutter_application_to_do/FireBaseUtils/fire_base_utils.dart';
import 'package:flutter_application_to_do/Models/user_model.dart';
import 'package:flutter_application_to_do/Screens/home_screen.dart';
import 'package:flutter_application_to_do/ThemeApp/theme_app.dart';
import 'package:provider/provider.dart';
import '../../Models/ProviderModels/auth_providers.dart';
import '../../Widgets/AuthWidgets/custom_text_form_field.dart';
import '../../Widgets/DialogUtils/custom_dialog_utils.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static String routeName = 'register screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController userNameController =
      TextEditingController(text: 'Mohamed');

  TextEditingController emailController =
      TextEditingController(text: 'mohamed@gmail.com');

  TextEditingController passwordController =
      TextEditingController(text: '2532001');

  TextEditingController confirmController =
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
            title: Text(
              AppLocalizations.of(context)!.app_title_loin,
            ),
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
                            //'Welcome Back !',
                            AppLocalizations.of(context)!.welocme_massage,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        CustomTextFormField(
                          label: AppLocalizations.of(context)!
                              .user_name, //'User Name',
                          keyBoradType: TextInputType.text,
                          controller: userNameController,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Please Enter User Name';
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          label:
                              AppLocalizations.of(context)!.email, // 'Email',
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
                          label: AppLocalizations.of(context)!
                              .password, //'Password',
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
                        CustomTextFormField(
                          label: AppLocalizations.of(context)!
                              .confirm_password, // 'Confirm Password',
                          keyBoradType: TextInputType.number,
                          controller: confirmController,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Please Enter Confirm Password';
                            }
                            if (text != passwordController.text)
                              return 'Confirm Password Doesnt Match Password ';
                            return null;
                          },
                          obscureText: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ElevatedButton(
                            onPressed: () {
                              register();
                            },
                            child: Text(
                              AppLocalizations.of(context)!
                                  .register, //'Register',
                              style: MyThemeApp.lightTheme.textTheme.titleLarge,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(LoginScreen.routeName);
                            },
                            child: Text(
                              AppLocalizations.of(context)!
                                  .or_you_have_create_account,
                              //  'Login!',
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

  void register() async {
    if (formKey.currentState!.validate() == true) {
      DialogUtils.showLoading(
        context: context,
        message: 'Loading.....',
        isDismissible: false,
      );
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        UserModel userModel = UserModel(
            userId: credential.user?.uid ?? '',
            userName: userNameController.text,
            userEmail: emailController.text);
        await FireBaseUtils.addUserToFireStore(userModel);
        var authProvider = Provider.of<AuthProviders>(context, listen: false);
        authProvider.updateUser(userModel);
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(
            context: context,
            message: AppLocalizations.of(context)!.register_sacsessfuly_massage,
            title: AppLocalizations.of(context)!.sacsess_massage,
            posActionName: AppLocalizations.of(context)!.ok_massage,
            posAction: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            context: context,
            message: 'The Password Provided Is Too Weak',
            title: 'Error',
            posActionName: AppLocalizations.of(context)!.ok_massage,
          );
        } else if (e.code == 'email-already-in-use') {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            context: context,
            message: 'The Account Already Exists For That Email',
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
        print(e.toString());
      }
    }
  }
}
