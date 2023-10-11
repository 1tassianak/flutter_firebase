import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/usuario.dart';
import '../viewmodels/usuario_view_model.dart';

class UsuarioDetailScreen extends StatefulWidget {
  const UsuarioDetailScreen({super.key});

  @override
  State<UsuarioDetailScreen> createState() => _UsuarioDetailScreenState();
}

class _UsuarioDetailScreenState extends State<UsuarioDetailScreen> {

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes do usuário"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'E-mail'),
            ),
            TextField(
              controller: _idadeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Idade'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () async{
                  Usuario usuario = Usuario(
                    nome:  _nomeController.text,
                    email: _emailController.text,
                    idade: int.tryParse(_idadeController.text) ?? 0,
                  );

                  await Provider.of<UsuarioViewModel>(context, listen: false).addUsuario(usuario);

                  Navigator.pop(context);
                },
                child: Text("Adicionar usuário"),
            ),
          ],
        ),
      ),
    );
  }
}
