import 'package:flutter/material.dart';
// own import
import 'package:sqflite_bloc/models/userModel.dart';
import 'package:sqflite_bloc/provider/add_users_bloc.dart';
import 'package:sqflite_bloc/widgets/add_user_dialog.dart';

class HomeList extends StatelessWidget {
  final List<UserModel> data;
  final AddUsersProvider addUsersBloc;

  HomeList({required this.data, required this.addUsersBloc});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Container(
                child: Center(
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 30.0,
                        child: Text(_getShortName(
                            data[index].firstName, data[index].lastName)),
                        backgroundColor: const Color(0xFF20283e),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                data[index].firstName +
                                    " " +
                                    data[index].lastName,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.lightBlueAccent),
                              ),
                              Text(
                                data[index].time,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.lightBlueAccent),
                              )
                            ],
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.cyan,
                            ),
                            onPressed: () =>
                                _openAddUserDialog(true, data[index], context),
                          ),
                          IconButton(
                              icon: const Icon(Icons.delete_forever,
                                  color: Colors.cyan),
                              onPressed: () async {
                                addUsersBloc.isDeleteUser.add(data[index].id!);
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0)),
          );
        });
  }

  String _getShortName(String firstName, String lastName) {
    String shortName = "";
    if (firstName.isNotEmpty) shortName = firstName.substring(0, 1) + ".";
    if (lastName.isNotEmpty) shortName = shortName + lastName.substring(0, 1);
    return shortName;
  }

  Future _openAddUserDialog(
      bool isEdit, UserModel userModel, BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddUserDialog(context, isEdit, addUsersBloc, userModel);
      },
    );
  }
}
