class UserLogged {
  int id;
  String username;
  String mail;
  String password;
  DateTime createdAt;

  UserLogged({
    required this.id,
    required this.username,
    required this.mail,
    required this.password,
    required this.createdAt,
  });

  factory UserLogged.fromJson(Map<String, dynamic> json) {
    return UserLogged(
      id: json['id'],
      username: json['username'],
      mail: json['mail'],
      password: json['password'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'mail': mail,
      'password': password,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class LoginResponse {
  UserLogged user;
  String token;

  LoginResponse({
    required this.user,
    required this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      user: UserLogged.fromJson(json['user']),
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'token': token,
    };
  }
}
