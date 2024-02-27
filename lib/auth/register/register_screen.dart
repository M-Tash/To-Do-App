import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/auth/register/custom_text_form_field.dart';
import 'package:todo_app/home_screen.dart';
import 'package:todo_app/providers/app_config_provider.dart';

import '../../my_theme.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'create_account_screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
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
            preferredSize: Size.fromHeight(180),
            child: AppBar(
              centerTitle: true,
              iconTheme: IconThemeData(
                  color: provider.isDarkMode()
                      ? MyTheme.blackColor
                      : Colors.white),
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 15, top: 0),
                        child: Form(
                          key: _formKey,
                          child: Padding(
                            padding: EdgeInsets.only(left: 5, right: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                CustomTextFormField(
                                  obscureText: false,
                                  label: AppLocalizations.of(context)!
                                      .user_name_label,
                                  controller: nameController,
                                  validator: (text) {
                                    if (text == null || text.trim().isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .error_user_name;
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 20),
                                CustomTextFormField(
                                  obscureText: false,
                                  label:
                                      AppLocalizations.of(context)!.email_label,
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
                                  label: AppLocalizations.of(context)!
                                      .password_label,
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
                                SizedBox(height: 20),
                                CustomTextFormField(
                                  icon: true,
                                  label: AppLocalizations.of(context)!
                                      .confirm_password_label,
                                  controller: confirmPasswordController,
                                  validator: (text) {
                                    if (text == null || text.trim().isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .error_password;
                                    }
                                    if (text != passwordController.text) {
                                      return AppLocalizations.of(context)!
                                          .error_confirm_password;
                                    }
                                    return null;
                                  },
                                ),
                                // TextFormField(
                                //   style:
                                //       Theme.of(context).textTheme.displaySmall,
                                //   onChanged: (text) {
                                //     firstName = text;
                                //   },
                                //   validator: (value) {
                                //     if (value == null || value.isEmpty) {
                                //       return AppLocalizations.of(context)!
                                //           .first_name_error;
                                //     }
                                //     return null;
                                //   },
                                //   decoration: InputDecoration(
                                //       enabledBorder: UnderlineInputBorder(
                                //         borderSide: BorderSide(
                                //             color: MyTheme.primaryColor),
                                //       ),
                                //       focusedBorder: UnderlineInputBorder(
                                //         borderSide: BorderSide(
                                //             color: MyTheme.primaryColor),
                                //       ),
                                //       hintText: AppLocalizations.of(context)!
                                //           .first_name_hint,
                                //       hintStyle: Theme.of(context)
                                //           .textTheme
                                //           .labelMedium),
                                // ),
                                //
                                // TextFormField(
                                //   style:
                                //       Theme.of(context).textTheme.displaySmall,
                                //   onChanged: (text) {
                                //     email = text;
                                //   },
                                //   validator: (text) =>
                                //       EmailValidator.validate(email)
                                //           ? null
                                //           : AppLocalizations.of(context)!
                                //               .error_email,
                                //   decoration: InputDecoration(
                                //       enabledBorder: UnderlineInputBorder(
                                //         borderSide: BorderSide(
                                //             color: MyTheme.primaryColor),
                                //       ),
                                //       focusedBorder: UnderlineInputBorder(
                                //         borderSide: BorderSide(
                                //             color: MyTheme.primaryColor),
                                //       ),
                                //       hintText: AppLocalizations.of(context)!
                                //           .email_hint,
                                //       hintStyle: Theme.of(context)
                                //           .textTheme
                                //           .labelMedium),
                                // ),
                                //
                                // TextFormField(
                                //   obscureText: !passwordVisible,
                                //   style:
                                //       Theme.of(context).textTheme.displaySmall,
                                //   onChanged: (text) {
                                //     password = text;
                                //   },
                                //   validator: (value) {
                                //     if (value == null || value.isEmpty) {
                                //       return AppLocalizations.of(context)!
                                //           .error_password;
                                //     }
                                //     return null;
                                //   },
                                //   decoration: InputDecoration(
                                //       suffixIcon: IconButton(
                                //         onPressed: () {
                                //           setState(() {
                                //             passwordVisible = !passwordVisible;
                                //           });
                                //         },
                                //         icon: Icon(
                                //           passwordVisible
                                //               ? Icons.visibility
                                //               : Icons.visibility_off,
                                //           color: MyTheme.loginColor,
                                //         ),
                                //       ),
                                //       enabledBorder: UnderlineInputBorder(
                                //         borderSide: BorderSide(
                                //             color: MyTheme.loginColor),
                                //       ),
                                //       focusedBorder: UnderlineInputBorder(
                                //         borderSide: BorderSide(
                                //             color: MyTheme.loginColor),
                                //       ),
                                //       hintText: AppLocalizations.of(context)!
                                //           .password_hint,
                                //       hintStyle: Theme.of(context)
                                //           .textTheme
                                //           .labelMedium),
                                // ),
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: InkWell(
                    onTap: () {
                      validate();
                    },
                    child: Container(
                      height: 55,
                      width: 334,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: provider.isDarkMode()
                                  ? MyTheme.primaryColor.withOpacity(0.5)
                                  : MyTheme.greyColor.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                          color: provider.isDarkMode()
                              ? MyTheme.loginColor
                              : Colors.white),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 40),
                          Text(
                            AppLocalizations.of(context)!.create_new_account,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: provider.isDarkMode()
                                        ? MyTheme.blackColor
                                        : MyTheme.greyColor),
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(right: 30),
                            child: Icon(Icons.arrow_forward,
                                size: 30,
                                color: provider.isDarkMode()
                                    ? MyTheme.blackColor
                                    : MyTheme.greyColor),
                          )
                        ],
                      ),
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

  void validate() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(context, HomeScreen.routeName);
    }
  }
}
