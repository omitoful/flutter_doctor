import 'package:flutter/material.dart';
import 'package:flutter_doctor/components/button.dart';
import 'package:flutter_doctor/main.dart';
import 'package:flutter_doctor/models/auth_model.dart';
import 'package:flutter_doctor/providers/dio_provider.dart';
import 'package:flutter_doctor/utils/config.dart';
import 'package:flutter_doctor/utils/text.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
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
            controller: _nameController,
            keyboardType: TextInputType.emailAddress,
            cursorColor: Config.primaryColor,
            decoration: InputDecoration(
              hintText: 'Username',
              labelText: 'Username',
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.person_outlined),
              prefixIconColor: Config.primaryColor,
            ),
          ),
          context.spaceSmall,
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
                title: 'Sign Up',
                onPressed: () async {
                  final userRegistration = await DioProvider().registerUser(
                    _nameController.text,
                    _emailController.text,
                    _passController.text,
                  );

                  if (userRegistration) {
                    final token = await DioProvider().getToken(
                      _emailController.text,
                      _passController.text,
                    );
                    if (token) {
                      auth.loginSuccess({}, {});
                      MyApp.navigatorKey.currentState!.pushNamed('main');
                    }
                  } else {
                    print('register failed.');
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
