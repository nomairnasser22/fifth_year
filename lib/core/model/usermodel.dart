class User {
  String? email;
  String? username;
  String? password;
  String? confpassword;

  User({this.username, this.email, this.password, this.confpassword});

  factory User.fromJson(Map<String, dynamic> user) {
    return User(
        email: user['email'],
        username: user['username'],
        password: user['password'],
        confpassword: user['confPassword']);
  }
  Map<String, dynamic> toJson() => {
        'email': email,
        'username': username,
        'password': password,
        'confPassword': confpassword
      };
}
