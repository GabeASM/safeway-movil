class CreateUser {
  CreateUser(this.email, this.password);
  late String username;
  String email;
  String password;

  bool isValidEmail() {
    // Expresión regular para validar email
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  bool isValidPassword() {
    // Regla para una contraseña segura:
    // Al menos 8 caracteres, una letra mayúscula, una letra minúscula, un número y un carácter especial
    final passwordRegex = RegExp(
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    return passwordRegex.hasMatch(password);
  }

  bool validate() {
    return isValidEmail() && isValidPassword();
  }
}
