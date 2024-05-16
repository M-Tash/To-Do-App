import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/auth/register/register_screen.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/home/home_screen.dart';
import 'package:todo_app/providers/app_config_provider.dart';

import '../../dialog_utils.dart';
import '../../my_theme.dart';
import '../../providers/user_provider.dart';
import '../register/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    return Stack(
      children: [
        Image.asset(
          provider.isDarkMode()
              ? 'assets/images/sign_in_dark.png'
              : 'assets/images/sign_in.png',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(220),
            child: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Text(
                AppLocalizations.of(context)!.app_title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
          ),
          body: Padding(
            padding: EdgeInsets.only(left: 5, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(AppLocalizations.of(context)!.welcome_back,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 15, top: 40),
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: EdgeInsets.only(left: 5, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CustomTextFormField(
                              obscureText: false,
                              label: AppLocalizations.of(context)!.email_label,
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (text) {
                                if (text == null || text.trim().isEmpty) {
                                  return AppLocalizations.of(context)!
                                      .error_email;
                                }

                                bool emailValid = RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(text);
                                if (!emailValid) {
                                  return AppLocalizations.of(context)!
                                      .error_valid_email;
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            CustomTextFormField(
                              icon: true,
                              label:
                                  AppLocalizations.of(context)!.password_label,
                              controller: passwordController,
                              validator: (text) {
                                if (text == null || text.trim().isEmpty) {
                                  return AppLocalizations.of(context)!
                                      .error_password;
                                }
                                if (text.length < 6) {
                                  return AppLocalizations.of(context)!
                                      .error_valid_password;
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    )),
                SizedBox(height: 30),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: InkWell(
                    onTap: () {
                      login();
                    },
                    child: Container(
                      height: 55,
                      width: 334,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: MyTheme.primaryColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 40),
                          Text(
                            AppLocalizations.of(context)!.login,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(right: 30),
                            child: Icon(Icons.arrow_forward,
                                size: 30,
                                color: provider.isDarkMode()
                                    ? MyTheme.blackColor
                                    : Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RegisterScreen.routeName);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.create_account,
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  void login() async {
    if (_formKey.currentState!.validate()) {
      DialogUtils.showLoading(
          context: context,
          message: AppLocalizations.of(context)!.loading,
          isDismissible: false);
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        var user = await FirebaseUtils.readUserFromFireStore(
            credential.user?.uid ?? '');
        if (user == null) {
          return;
        }
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(user);
        DialogUtils.hideLoading(context: context);
        DialogUtils.showSnackBar(
            context: context,
            message: AppLocalizations.of(context)!.login_successful);
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showSnackBar(
              context: context,
              message: AppLocalizations.of(context)!.wrong_email);
          print(
              'The supplied auth credential is incorrect, malformed or has expired');
        } else if (e.code == 'wrong-password') {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showSnackBar(
              context: context,
              message: AppLocalizations.of(context)!.wrong_password);
          print('Wrong password provided for that user.');
        }
      } catch (e) {
        DialogUtils.hideLoading(context: context);
        DialogUtils.showSnackBar(context: context, message: e.toString());
        print(e.toString());
      }
    }
  }
}
