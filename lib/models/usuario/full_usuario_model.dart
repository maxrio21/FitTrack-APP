//full_usuario_model
class FullUserModel {
  final int id;
  final String nombre;
  final String nickname;
  final String email;
  final bool admin;
  final String fecha_registro;
  final String ultima_conexion;
  final String fecha_nac;

  FullUserModel({
    required this.id,
    required this.nombre,
    required this.nickname,
    required this.email,
    required this.admin,
    required this.fecha_registro,
    required this.ultima_conexion,
    required this.fecha_nac,
  });

  factory FullUserModel.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return FullUserModel(
        id: json['id'] as int,
        nombre: json['nombre'] as String,
        nickname: json['nickname'] as String,
        email: json['email'] as String,
        admin: json['admin'] as bool,
        fecha_registro: json['fecha_registro'] as String,
        ultima_conexion: json['ultima_conexion'] as String,
        fecha_nac: json['fecha_nac'] as String,
      );
    } else {
      throw ArgumentError('Invalid JSON format for FullUserModel');
    }
  }

  static List<FullUserModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => FullUserModel.fromJson(json)).toList();
  }
}
