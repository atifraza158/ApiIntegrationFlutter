import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void signUp(String email, password)async {
    try {
      Response response = await post(
        //if login then Just change the api end point with "https://reqres.in/api/login"
        Uri.parse("https://reqres.in/api/register"),
        body: {
          'email': email,
          'password': password
        }
      );

      if(response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data);
        print("Account Created Successfully");
      } else {
        print("Account Creation Failed");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up Api"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Email",
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: "Password",
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: MaterialButton(
                    height: 60,
                    minWidth: 100,
                    textColor: Colors.white,
                    color: Colors.deepPurple,
                    onPressed: () {
                      signUp(emailController.text.toString(), passwordController.text.toString());                    },
                    child: Text("Sign Up"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
