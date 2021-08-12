import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// own import
import 'package:sqflite_bloc/models/userModel.dart';
import 'package:sqflite_bloc/provider/add_users_bloc.dart';
class AddUserDialog extends StatelessWidget {
  final BuildContext context;
  final bool isEdit;

  final AddUsersProvider addUsersBloc;
  final UserModel? userModel;

  AddUserDialog(this.context, this.isEdit, this.addUsersBloc, this.userModel);

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        isEdit ? 'Edit' : 'Add new User', textAlign: TextAlign.center,),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getTextField("First name", _firstNameController),
            getTextField("Last name", _lastNameController),
            GestureDetector(
              onTap: () {
                // dialogOnTap(isEdit);
                _saveData();
                Navigator.of(context).pop();
              },
              child: Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                  child: getAppBorderButton(isEdit ? "Edit" : "Add",)
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getTextField(String inputBoxName,
      TextEditingController inputBoxController) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: TextFormField(
        controller: inputBoxController,
        decoration: InputDecoration(
          hintText: inputBoxName,
        ),
      ),
    );
  }

  Widget getAppBorderButton(String buttonLabel) {
    return Container(
      padding: EdgeInsets.all(8.0),
      alignment: FractionalOffset.center,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF28324E)),
        borderRadius: BorderRadius.all(const Radius.circular(6.0)),
      ),
      child: Text(
        buttonLabel,
        style: TextStyle(
          color: const Color(0xFF28324E),
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  void _saveData() {
    if (isEdit == false) {
      addUsersBloc.insertUser.add(UserModel( firstName: _firstNameController.text,lastName: _lastNameController.text,time: nowTime()));
    } else {
      addUsersBloc.inUpdateUser.add(UserModel(id: userModel!.id, firstName: _firstNameController.text,lastName: _lastNameController.text,time: nowTime()));
    }
  }
  String nowTime(){
    final now = DateTime.now();
    String date = DateFormat("yyyy-MM-dd").format(now);
    String time = DateFormat("H:m:s").format(now);
    return date+" "+time;
  }
}
