//login_usuario_model
class LoginUsuarioModel {
  final String email;
  final String contrasenya;

  LoginUsuarioModel({
    required this.email,
    required this.contrasenya,
  });

  factory LoginUsuarioModel.fromJson(Map<String, dynamic> json) {
    return LoginUsuarioModel(
      email: json['email'] as String,
      contrasenya: json['contrasenya'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'contrasenya': contrasenya,
    };
  }
}