// import 'package:api_integration/getApi/access_product_model.dart';
// import 'package:api_integration/postApi/sign_up.dart';
import 'package:api_integration/postApi/upload_image.dart';
// import 'package:api_integration/getApi/custom_user_model_api.dart';
// import 'package:api_integration/getApi/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const UploadImage()
    );
  }
}
