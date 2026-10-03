import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_doctor/components/button.dart';
import 'package:flutter_doctor/main.dart';
import 'package:flutter_doctor/models/auth_model.dart';
import 'package:flutter_doctor/providers/dio_provider.dart';
import 'package:flutter_doctor/utils/config.dart';
import 'package:flutter_doctor/utils/text.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool obscurePass = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            cursorColor: Config.primaryColor,
            decoration: InputDecoration(
              hintText: 'Email Address',
              labelText: 'Email',
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.email_outlined),
              prefixIconColor: Config.primaryColor,
            ),
          ),
          context.spaceSmall,
          TextFormField(
            controller: _passController,
            keyboardType: TextInputType.visiblePassword,
            cursorColor: Config.primaryColor,
            obscureText: obscurePass,
            decoration: InputDecoration(
              hintText: 'Password',
              labelText: 'Password',
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.lock_outline),
              prefixIconColor: Config.primaryColor,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obscurePass = !obscurePass;
                  });
                },
                icon: obscurePass
                    ? Icon(Icons.visibility_off_outlined, color: Colors.black38)
                    : Icon(Icons.visibility_outlined, color: Config.primaryColor),
              ),
            ),
          ),
          context.spaceSmall,
          Center(
            child: TextButton(
              onPressed: () {},
              child: Text(
                AppText.enText['forgot-password']!,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          context.spaceSmall,
          Consumer<AuthModel>(
            builder: (context, auth, child) {
              return Button(
                width: double.infinity,
                title: 'Sign In',
                onPressed: () async {
                  final token = await DioProvider().getToken(
                    _emailController.text,
                    _passController.text,
                  );
                  if (token) {
                    final SharedPreferences prefs = await SharedPreferences.getInstance();
                    final token = prefs.getString('token') ?? '';
                    if (token.isNotEmpty && token != '') {
                      final response = await DioProvider().getUser(token);
                      if (response != null) {
                        setState(() {
                          Map<String, dynamic> appointment = {};
                          final user = json.decode(response);

                          for (var doctorData in user['doctor']) {
                            if (doctorData['appointments'] != null) {
                              appointment = doctorData;
                            }
                          }
                          auth.loginSuccess(user, appointment);
                          MyApp.navigatorKey.currentState!.pushNamed('main');
                          // Navigator.of(context).pushNamed('main');
                        });
                      }
                    }
                  }
                },
                disable: false,
              );
            },
          ),
        ],
      ),
    );
  }
}
