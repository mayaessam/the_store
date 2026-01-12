import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:the_store/core/utils/app_fonts.dart';
import 'package:the_store/featues/add_product/widgets/custom_textformfield_witth%20title.dart';

import '../../home/presentation/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Dio dio=Dio();
  Future<void> login(BuildContext context) async {
    try {
      final response = await dio.post(
        'https://fakestoreapi.com/auth/login',
        data: {
          "username": usernameController.text.trim(),
          "password": passwordController.text.trim(),
        },
      );

      final token = response.data['token'];

      if (token != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen()),
        );
      }
    } on DioException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login failed')),
      );
    }
  }


  void clear(){
    usernameController.clear();
    passwordController.clear();
  }
  final TextEditingController usernameController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar:  AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              CustomTextFormFieldWithTitle(fieldLabel: 'user name',
                  controller: usernameController,
                  hint: 'user name'),
              SizedBox(height: 40,),
              CustomTextFormFieldWithTitle(fieldLabel: 'password',
                  controller: passwordController,
                  hint: 'password'),
              SizedBox(height: 60,),
              ElevatedButton(
                onPressed: () async {
                  if (usernameController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Fill all fields')),
                    );
                    return;
                  }

                  await login(context);
                },
                child: Text(
                  'Login',
                  style: AppTextStyles.mediumBold,
                ),
              ),

            ],
          ),
        ),

      );
  }
}
