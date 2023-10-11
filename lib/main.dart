import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase/screens/usuario_list_screen.dart';
import 'package:flutter_firebase/viewmodels/usuario_view_model.dart';
import 'package:provider/provider.dart';


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //FirebaseFirestore.instance.collection('Disciplinas').doc('DevMobile').set({'Conteudo' : 'Banco de dados', 'dica' : 'criem apps!'});

  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return ChangeNotifierProvider(
      create: (context) => UsuarioViewModel(),
      child: MaterialApp(
        home: UsuarioListScreen(),
      )
    );
  }
}

