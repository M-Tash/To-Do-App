import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/create_account_screen.dart';
import 'package:todo_app/home_screen.dart';
import 'package:todo_app/providers/app_config_provider.dart';

import 'my_theme.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  String email = '';
  String password = '';
  bool passwordVisible = false;
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
            preferredSize: Size.fromHeight(250),
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
                            TextFormField(
                              style: Theme.of(context).textTheme.displaySmall,
                              onChanged: (text) {
                                email = text;
                              },
                              validator: (value) =>
                                  EmailValidator.validate(email)
                                      ? null
                                      : AppLocalizations.of(context)!
                                          .error_email,
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyTheme.primaryColor),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyTheme.primaryColor),
                                  ),
                                  hintText:
                                      AppLocalizations.of(context)!.email_hint,
                                  hintStyle:
                                      Theme.of(context).textTheme.labelMedium),
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              obscureText: !passwordVisible,
                              style: Theme.of(context).textTheme.displaySmall,
                              onChanged: (text) {
                                password = text;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppLocalizations.of(context)!
                                      .error_password;
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        passwordVisible = !passwordVisible;
                                      });
                                    },
                                    icon: Icon(
                                      passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: MyTheme.loginColor,
                                    ),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyTheme.loginColor),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyTheme.loginColor),
                                  ),
                                  hintText: AppLocalizations.of(context)!
                                      .password_hint,
                                  hintStyle:
                                      Theme.of(context).textTheme.labelMedium),
                            ),
                          ],
                        ),
                      ),
                    )),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: InkWell(
                    onTap: () {},
                    child: Text(
                      AppLocalizations.of(context)!.forgot_password,
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(fontSize: 14),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushNamed(context, HomeScreen.routeName);
                      }
                    },
                    child: Container(
                      height: 55,
                      width: 334,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: MyTheme.loginColor),
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
                      Navigator.pushNamed(
                          context, CreateAccountScreen.routeName);
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
}
