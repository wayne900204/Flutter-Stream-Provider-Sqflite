import 'package:flutter/material.dart';
// own import
import 'package:sqflite_bloc/bloc/add_user_bloc_provider.dart';
import 'package:sqflite_bloc/bloc/add_users_bloc.dart';
import 'package:sqflite_bloc/screens/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: AddUserBlocProvider(
        bloc: AddUsersBloc(),
        child: HomePage(),
      ),
    );
  }
}
