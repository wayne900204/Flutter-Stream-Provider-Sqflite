import 'dart:async';
// own import
import 'package:sqflite_bloc/db/user_db.dart';
import 'package:sqflite_bloc/models/userModel.dart';
import 'add_user_bloc_provider.dart';

class AddUsersBloc implements BlocBase {

  // Create a broadcast controller that allows this stream to be listened
  // to multiple times. This is the primary, if not only, type of stream you'll be using.
  final _usersController = StreamController<List<UserModel>>.broadcast();
  // Input stream. We add our users to the stream using this variable.
  StreamSink<List<UserModel>> get _inUserSink => _usersController.sink;
  // Output stream. This one will be used within our pages to display the users.
  Stream<List<UserModel>> get getUserStream => _usersController.stream;



  final _insertController = StreamController<UserModel>.broadcast();
  final _updateController = StreamController<UserModel>.broadcast();
  final _deleteController  = StreamController<int>.broadcast();
  final _searchController = StreamController<String>.broadcast();


  StreamSink<UserModel> get insertUser => _insertController.sink;
  StreamSink<UserModel> get inUpdateUser => _updateController.sink;
  StreamSink<int> get isDeleteUser => _deleteController.sink;
  StreamSink<String> get isSearchUser => _searchController.sink;



  // Input stream for adding new users. We'll call this from our pages.
  AddUsersBloc() {
    // Retrieve all the users on initialization
    updateScreenData();
    _updateController.stream.listen(_handleUpdateUser);
    // Listens for changes to the addUserController and calls _handleAddUser on change
    _insertController.stream.listen(_handleAddUser);
    _deleteController.stream.listen(_handleDeleteUser);
    _searchController.stream.listen(_handleSearchUser);
  }

  void updateScreenData() async {
    // Retrieve all the users from the database
    List<UserModel> users = await UserDBProvider.db.getUser();

    // Add all of the users to the stream so we can grab them later from our pages
    _inUserSink.add(users);
  }

  void _handleAddUser(UserModel userModel) async {
    // Create the note in the database
    await UserDBProvider.db.insertUserData(userModel);

    // Retrieve all the notes again after one is added.
    // This allows our pages to update properly and display the
    // newly added note.
    updateScreenData();
  }

  void _handleUpdateUser(UserModel userModel) async {
    await UserDBProvider.db.updateUser(userModel);
    updateScreenData();
  }
  void _handleDeleteUser(int id) async{
    await UserDBProvider.db.deleteUser(id);
    updateScreenData();
  }
  void _handleSearchUser(String text) async{

    List<UserModel> user = await UserDBProvider.db.getUser();

    var dummyListData = List<UserModel>();
    user.forEach((stud) {
      var st2 = UserModel(id: stud.id, lastName: stud.lastName,firstName: stud.firstName,time: stud.time);
      if ((st2.firstName.toLowerCase()+" "+st2.lastName.toLowerCase()).contains(text.toLowerCase())
          || st2.firstName.toLowerCase().contains(text.toLowerCase())
      || st2.lastName.toLowerCase().contains(text.toLowerCase())
      || st2.time.toLowerCase().contains(text.toLowerCase())
      ) {
        dummyListData.add(stud);
      }
    });
    _inUserSink.add(dummyListData);
  }

  // All stream controllers you create should be closed within this function
  @override
  void dispose() {
    _usersController.close();
    _insertController.close();
    _deleteController.close();
    _updateController.close();
    _searchController.close();
  }
}
