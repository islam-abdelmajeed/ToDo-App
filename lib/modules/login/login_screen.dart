import 'package:flutter/material.dart';
import 'package:todo_app/layout/home_layout.dart';
import 'package:todo_app/shared/components/reusable_components.dart';

class LoginScreen extends StatefulWidget {
  static const loginScreenRoute = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Login - label
                Text(
                  'Login',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50.0,
                  ),
                ),

                //SizedBox
                SizedBox(
                  height: 30.0,
                ),

                //Email Address
                defaultTextEditing(
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  label: 'Email Address',
                  prefix: Icons.email,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'email address can not be empty!';
                    } else {
                      if (!value.contains('@')) {
                        return 'wrong email address!';
                      }
                    }
                    return null;
                  },
                ),

                SizedBox(
                  height: 15.0,
                ),

                //Password
                defaultTextEditing(
                  controller: passwordController,
                  type: TextInputType.visiblePassword,
                  label: 'Password',
                  prefix: Icons.lock,
                  isPassword: isPassword,
                  suffix: isPassword ? Icons.visibility_off : Icons.visibility,
                  onShowPassword: () {
                    setState(() {
                      isPassword = !isPassword;
                    });
                  },
                ),

                SizedBox(
                  height: 30,
                ),

                //LoginButton
                defaultButton(
                    label: 'login',
                    onPressButton: () {
                      Navigator.of(context)
                          .pushNamed(HomeLayout.homeScreenRoute);
                    }),

                SizedBox(
                  height: 10,
                ),

                //Divider
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 1,
                      color: Colors.black,
                    ),
                    Text(
                      '\t OR \t',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Container(
                      width: 120,
                      height: 1,
                      color: Colors.black,
                    ),
                  ],
                ),

                SizedBox(
                  height: 10,
                ),

                defaultButton(label: 'Register'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
