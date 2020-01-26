import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Future<Database> _recuperarBancoDados() async{
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, "banco.db");

    var bd = await openDatabase(
      localBancoDados,
      version: 1,
      onCreate: (db, dbVersaoRecente){
        db.execute("CREATE TABLE TB_USUARIO(ID_USUARIO INTEGER PRIMARY KEY AUTOINCREMENT, NOME VARCHAR, IDADE INTEGER)");
    });

    return bd;
  }

  _salvarUsuario() async{

    Database bd = await _recuperarBancoDados();

    Map<String, dynamic> usuario = {
      "nome": "Quim",
      "idade":  26
    };

    int idInsert = await bd.insert("TB_USUARIO", usuario);

    print(idInsert);


  }




  @override
  Widget build(BuildContext context) {
    _salvarUsuario();


    return Scaffold(
      appBar: AppBar(
        title: Text("Banco de dados"),
        backgroundColor: Colors.indigoAccent,
      ),
      body: Container(

      ),
    );
  }
}
