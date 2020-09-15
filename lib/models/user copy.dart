import '../string_util.dart';

enum LoginType { email, phone }

class User {
  String email;
  String phone;

  String _lastName;
  String _firstName;
  LoginType _type;

  List<User> friends = [];

  User._({String firstName, String lastName, String phone, String email})
      : _lastName = lastName,
        _firstName = firstName,
        this.phone = phone,
        this.email = email {
    print("User is created");
    _type = email != null ? LoginType.email : LoginType.phone;
  }

  factory User({String name, String phone, String email}) {
    if (name.isEmpty) throw Exception("User name is empty");
    if (phone == null || phone.isEmpty)
      throw Exception("Enter don't empty phone number");

    return User._(
        firstName: _getFirstName(name),
        lastName: _getLastName(name),
        phone: checkPhone(phone),
        email: email);
  }

  static String _getLastName(String userName) => userName.split(" ")[1];
  static String _getFirstName(String userName) => userName.split(" ")[0];

  static String checkPhone(String phone) {
    String pattern = r"^(?:[+0])?[0-9]{11}";
    // if (phone != null && phone.isNotEmpty) {
    phone = phone.replaceAll(RegExp("[^+\\d]"), "");
    // }
    /*if (phone == null || phone.isEmpty) {
      throw Exception("Enter don't empty phone number");
    } else*/
    if (!RegExp(pattern).hasMatch(phone)) {
      throw Exception(
          "Enter a valid phone number starting with a + and containing 11 digits");
    }

    print(phone);
    return phone;
  }

  // static String checkEmail(String email) {

  //   if (email == null || email.isEmpty) {
  //     throw Exception("Enter don't empty email");
  //   }
  //   return email;
  // }

  String get login {
    if (_type == LoginType.phone) return phone;
    return email;
  }

  String get name => "${''.capitalize(_firstName)} ${''.capitalize(_lastName)}";

  @override
  bool operator ==(Object object) {
    if (object == null) {
      return false;
    }

    if (object is User) {
      return _firstName == object._firstName &&
          _lastName == object._lastName &&
          (phone == object.phone || email == object.email);
    }
  }

  void addFriend(Iterable<User> newFriend) {
    friends.addAll(newFriend);
  }

  void removeFriend(User user) {
    friends.remove(user);
  }

  @override
  String toString() {
    return '''
    name: $name
    email: $email
    phone: $phone
    friends: ${friends.toList()}
    ''';
  }
}
