class UserModel {
  final String id;
  final String login;
  final String senha;

  UserModel({
    required this.id,
    required this.login,
    required this.senha,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      login: json["login"],
      senha: json["senha"],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      "login": login,
      "senha": senha,
    };
  }
}
