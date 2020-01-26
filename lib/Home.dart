import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  _recuperarBancoDados() async{
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, "banco.db");

    var retorno = await openDatabase(
      localBancoDados,
      version: 1,
      onCreate: (db, dbVersaoRecente){
        db.execute("CREATE TABLE TB_USUARIO(ID_USUARIO INTEGER PRIMARY KEY AUTOINCREMENT, NOME VARCHAR, IDADE INTEGER)");
    });

    print(retorno.isOpen);

  }


  @override
  Widget build(BuildContext context) {
    _recuperarBancoDados();
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
