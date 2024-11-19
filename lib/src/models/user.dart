class User {
  int? _id;
  String _firstName;
  String _lastName;
  String _email;
  String _phoneNumber;
  String _password;
  bool _isVerified;

  User({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String password,
    required bool isVerified,
  })  : _firstName = firstName,
        _lastName = lastName,
        _email = email,
        _phoneNumber = phoneNumber,
        _password = password,
        _isVerified = isVerified;

  User.withId({
    required int id,
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String password,
    bool isVerified = false,
  })  : _id = id,
        _firstName = firstName,
        _lastName = lastName,
        _email = email,
        _phoneNumber = phoneNumber,
        _password = password,
        _isVerified = isVerified;

  int? get id => _id;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get email => _email;
  String get phoneNumber => _phoneNumber;
  String get password => _password;
  bool get isVerified => _isVerified;

  set firstName(String newFirstName) {
    if (newFirstName.isNotEmpty) {
      _firstName = newFirstName;
    } else {
      throw Exception('First name cannot be empty');
    }
  }

  set lastName(String newLastName) {
    if (newLastName.isNotEmpty) {
      _lastName = newLastName;
    } else {
      throw Exception('Last name cannot be empty');
    }
  }

  set email(String newEmail) {
    if (_isValidEmail(newEmail)) {
      _email = newEmail;
    } else {
      throw Exception('Invalid email format');
    }
  }

  set phoneNumber(String newPhoneNumber) {
    if (newPhoneNumber.isNotEmpty) {
      _phoneNumber = newPhoneNumber;
    } else {
      throw Exception('Phone number cannot be empty');
    }
  }

  set password(String newPassword) {
    if (_isValidPassword(newPassword)) {
      _password = newPassword;
    } else {
      throw Exception('Password does not meet security requirements');
    }
  }

  set isVerified(bool newIsVerified) {
    _isVerified = newIsVerified;
  }

  bool _isValidEmail(String email) {
    return email.contains('@') && email.contains('.');
  }

  bool _isValidPassword(String password) {
    return password.length >= 8 &&
        password.contains(RegExp(r'[a-zA-Z]')) &&
        password.contains(RegExp(r'[0-9]'));
  }

  // Convert a User object into a Map object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (_id != null) {
      map['id'] = _id;
    }
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['email'] = _email;
    map['phoneNumber'] = _phoneNumber;
    map['password'] = _password;
    map['isVerified'] = _isVerified ? 1 : 0; // Convert bool to int for database storage
    return map;
  }

  // Convert a Map object into a User object
  factory User.fromMap(Map<String, dynamic> json) {
    return User.withId(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      password: json['password'],
      isVerified: json['isVerified'] == 1, // Convert int to bool
    );
  }
}
