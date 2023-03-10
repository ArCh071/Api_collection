import 'package:collection_app/view/collection.dart';
import 'package:collection_app/view/collection_post.dart';
import 'package:collection_app/view/first_page.dart';
import 'package:collection_app/view/registration_form.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const First_page(),
    );
  }
}
