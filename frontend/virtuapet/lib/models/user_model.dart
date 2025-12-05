class UserModel {
  final String id;
  final String login;
  final String senha;
  final bool hasPet;

  UserModel({
    required this.id,
    required this.login,
    required this.senha,
    required this.hasPet,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      login: json["login"],
      senha: json["senha"],
      hasPet: json["hasPet"] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "login": login,
      "senha": senha,
      "hasPet": hasPet,
    };
  }
}
