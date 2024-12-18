class User {
  final String email;
  final String password;
  final String gender;
  final int age;
  final bool receiveNotifications;
  final String notes;

  User({
    required this.email,
    required this.password,
    required this.gender,
    required this.age,
    required this.receiveNotifications,
    required this.notes,
  });
}

List<User> userList = [];
