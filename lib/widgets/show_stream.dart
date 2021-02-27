import 'package:flutter/material.dart';
// own import
import 'package:sqflite_bloc/bloc/add_user_bloc_provider.dart';
import 'package:sqflite_bloc/bloc/add_users_bloc.dart';
import 'package:sqflite_bloc/models/userModel.dart';
import 'package:sqflite_bloc/widgets/home_list.dart';
class ShowAll extends StatefulWidget {
  @override
  _ShowAllState createState() => _ShowAllState();
}

class _ShowAllState extends State<ShowAll> {
  AddUsersBloc addUsersBloc;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    addUsersBloc = AddUserBlocProvider.of<AddUsersBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UserModel>>(
      stream: addUsersBloc.getUserStream,
      builder: (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
        // Make sure data exists and is actually loaded
        if (snapshot.hasData) {
          // If there are no user (data), display this message.
          if (snapshot.data.length == 0) {
            return Text('No Data');
          }
          return HomeList(data: snapshot.data,addUsersBloc: addUsersBloc);
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
