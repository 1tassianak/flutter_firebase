import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/usuario_detail_screen.dart';
import 'package:provider/provider.dart';

import '../models/usuario.dart';
import '../viewmodels/usuario_view_model.dart';

class UsuarioListScreen extends StatefulWidget {
  const UsuarioListScreen({super.key});

  @override
  State<UsuarioListScreen> createState() => _UsuarioListScreenState();
}

class _UsuarioListScreenState extends State<UsuarioListScreen> {

  @override
  void initState(){
    super.initState();
    Provider.of<UsuarioViewModel>(context, listen: false).getUsuarios();
  }

  @override
  Widget build(BuildContext context) {

    var usuarioViewModel = Provider.of<UsuarioViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de usuários"),
      ),
      body: StreamBuilder<List<Usuario>>(
        stream: usuarioViewModel.getUsuariosStream(),
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else if (snapshot.hasError){
            return Center(
              child: Text("Erro: ${snapshot.error}"),
            );
          }else{
            List<Usuario>? usuarios = snapshot.data;
            return ListView.builder(
              itemCount: usuarios?.length,
              itemBuilder: (context, index){
                return ListTile(
                  title: Text(usuarios![index].nome),
                  subtitle: Text(usuarios![index].email),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UsuarioDetailScreen()
                      )
                    );
                  },
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: (){
                      if (usuarios[index].id != null){
                        usuarioViewModel.delete(usuarios[index].id!);
                      }
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UsuarioDetailScreen()
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
