class UserModel {
  final int id;
  final String firstName;
  final String lastName;
  final String time;
  UserModel({this.id, this.firstName,this.lastName,this.time});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName' : lastName,
      'time' : time,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      time: map['time'],
    );
  }
}
