import 'dart:core';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:snappio_frontend/screens/chat_section.dart';
import 'package:snappio_frontend/screens/login_page.dart';
import 'package:snappio_frontend/themes.dart';
import 'package:snappio_frontend/services/auth_services.dart';
import '../constants/snackbar.dart';
import '../services/auth_services.dart';

class SignupPage extends StatefulWidget {
  static const String routeName = "/signup";
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final RoundedLoadingButtonController _controller =
      RoundedLoadingButtonController();
  static String _username = "";
  static String _email = "";
  static String _name = "";
  static String _password = "";

  bool validEmail() {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+")
        .hasMatch(_email);
  }

  bool validUsername() {
    return RegExp(r"^(?=[a-z0-9]{4,10}$)").hasMatch(_username);
  }

  signupBtnPressed(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {});
      var res = AuthServices().signupUser(
        username: _username,
        email: _email,
        name: _name,
        password: _password,
      );

      if (await res) {
        showSnackBar(context, "Success: Account created");
        _controller.success();
        await Future.delayed(const Duration(seconds: 2));
        Navigator.pushReplacementNamed(context, ChatSection.routeName);
      } else {
        showSnackBar(context, "Error: User already exists");
        _controller.error();
        await Future.delayed(const Duration(seconds: 2));
        _controller.reset();
      }
    } else {
      _controller.error();
      await Future.delayed(const Duration(seconds: 2));
      _controller.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Column(
            children: [
              Image.asset("assets/images/signup.png"),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 42),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Join Snappio",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textScaleFactor: 2.6),
                    const SizedBox(height: 50),
                    Form(
                      key: _formKey,
                      child: Column(children: [
                        TextFormField(
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.account_box_outlined),
                              labelText: "Name",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                              // filled: true,
                              contentPadding: EdgeInsets.all(15)),
                          onChanged: (value) => _name = value,
                          validator: (value) {
                            if (value!.isEmpty)
                              return "Please provide your name";
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.account_circle_rounded),
                              labelText: "Username",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                              // filled: true,
                              contentPadding: EdgeInsets.all(15)),
                          onChanged: (value) => _username = value,
                          validator: (value) {
                            if (value!.length < 4 || value.length > 10) {
                              return "Username should be 4-10 characters long";
                            } else if (!validUsername()) {
                              return "Only lowercase alphabets and numbers supported";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email_rounded),
                            labelText: "Email",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                            // filled: true,
                            contentPadding: EdgeInsets.all(15),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) => _email = value,
                          validator: (value) {
                            return validEmail() ? null : "Invalid email";
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.verified_user),
                              labelText: "Password",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                              // filled: true,
                              contentPadding: EdgeInsets.all(15)),
                          obscureText: true,
                          onChanged: (value) => _password = value,
                          validator: (value) {
                            if (value!.length < 6) {
                              return "Password must be atleast 6 characters";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.lock_rounded),
                              hintText: "Confirm password",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                              // filled: true,
                              contentPadding: EdgeInsets.all(15)),
                          obscureText: true,
                          validator: (value) {
                            if (value != _password)
                              return "Passwords don't match";
                            return null;
                          },
                        ),
                      ]),
                    ),
                    const SizedBox(height: 50),
                    RoundedLoadingButton(
                      controller: _controller,
                      onPressed: () => signupBtnPressed(context),
                      animateOnTap: true,
                      height: 54,
                      elevation: 3,
                      successColor: Colors.green,
                      color: Theme.of(context).cardColor,
                      child: const Text("Sign In",
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textScaleFactor: 1.4),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account? "),
                        InkWell(
                          onTap: () => Navigator.pushReplacementNamed(
                              context, LoginPage.routeName),
                          child: const Text(" Sign In",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Themes.darkAccent)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
