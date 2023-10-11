import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/usuario.dart';

class UsuarioViewModel extends ChangeNotifier{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference _usuarioCollection = FirebaseFirestore.instance.collection('usuarios');

  Future<List<Usuario>> getUsuarios() async {
    try {
      QuerySnapshot querySnapshot = await _usuarioCollection.get();
      List<Usuario> usuarios = querySnapshot.docs.map((doc) {
        return Usuario(
          id: doc.id,
          nome: doc['name'],
          email: doc['email'],
          idade: doc['age'],
        );
      }).toList();
      return usuarios;
    } catch (e) {
      print("Erro ao obter usuários: $e");
      return [];
    }
  }

  Stream<List<Usuario>> getUsuariosStream() {
    try {
      return _usuarioCollection.snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          return Usuario(
            id: doc.id,
            nome: doc['name'],
            email: doc['email'],
            idade: doc['age'],
          );
        }).toList();
      });
    } catch (e) {
      print("Erro ao obter usuários: $e");
      return Stream.value([]);
    }
  }

  Future<void> addUsuario(Usuario usuario) async{
    try{
      await _usuarioCollection.add(usuario.toMap());
    }catch (e){
      print("Erro ao adicionar usuário: $e");
    }
  }

  Future<void> delete(String usuarioId) async{
    try{
      await _usuarioCollection.doc(usuarioId).delete();
    }catch (e){
      print("Erro ao excluir usuário: $e");
    }
  }

}