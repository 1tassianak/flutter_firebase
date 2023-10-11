class Usuario {
  String? id;
  late String nome;
  late String email;
  late int idade;

  Usuario({this.id, required this.nome, required this.email, required this.idade});

  Map<String, dynamic> toMap() {
    return {
      'name': nome,
      'email': email,
      'age': idade,
    };
  }
}
