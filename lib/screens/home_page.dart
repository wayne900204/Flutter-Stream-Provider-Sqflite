import 'package:flutter/material.dart';
import '../widgets/show_stream.dart';
import 'package:provider/provider.dart';
// own import
import 'package:sqflite_bloc/widgets/add_user_dialog.dart';
import 'package:sqflite_bloc/provider/add_users_bloc.dart';
class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController _searchController = TextEditingController();
  AddUsersProvider? addUsersBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    addUsersBloc = context.watch<AddUsersProvider>();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        centerTitle: true,
        title: Text('sqflite Demo',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,letterSpacing: 1.5),),
        actions: _buildActions(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _searchField(),
          Expanded(child: ShowAll()),
        ],
      ),
    );
  }

  // searchField
  Widget _searchField(){
    return TextFormField(
      style: TextStyle(fontSize: 14.0, color: Colors.black),
      controller: _searchController,
      onChanged: (changed) {
        addUsersBloc!.isSearchUser.add(changed);
      },
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        filled: true,
        fillColor: Colors.grey[100],
        suffixIcon: _searchController.text.length > 0 ? IconButton(
            icon: Icon(Icons.search_outlined, color: Colors.grey[500], size: 16.0,),
            onPressed: () {}): Icon(Icons.search_outlined, color: Colors.grey[500], size: 16.0,),
        enabledBorder: OutlineInputBorder(
            borderSide:  BorderSide(color: Colors.grey[100]!.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(30.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[100]!.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(30.0)),
        contentPadding: EdgeInsets.only(
            left: 15.0, right: 10.0),
        labelText: "Search...",
        hintStyle: TextStyle(
            fontSize: 14.0,
            color: Colors.grey,
            fontWeight: FontWeight.w500),
        labelStyle: TextStyle(
            fontSize: 14.0,
            color: Colors.grey,
            fontWeight: FontWeight.w500),
      ),
      autocorrect: false,
      autovalidateMode: AutovalidateMode.always,
    );
  }
  // appbar Actions
  List<Widget> _buildActions() {
    return <Widget>[
      IconButton(
          icon: const Icon(
            Icons.group_add,
            color: Colors.white,
          ),
          onPressed: (){_openAddUserDialog(false);}
      ),
    ];
  }

  Future _openAddUserDialog(bool isEdit) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddUserDialog(context, isEdit,addUsersBloc!,null);
      },
    );
    // setState(() {});
  }
}
