import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_bloc/provider/add_users_bloc.dart';
import 'package:sqflite_bloc/screens/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AddUsersProvider>(
          create: (context) => new AddUsersProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.cyan,
        ),
        home: HomePage(),
      ),
    );
  }
}
