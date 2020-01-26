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
      "nome": "Teste 7",
      "idade":  28
    };

    int idInsert = await bd.insert("TB_USUARIO", usuario);
    print(idInsert);
  }

  _listarUsuario() async{

    Database bd = await _recuperarBancoDados();

    List usuarios = await bd.rawQuery("SELECT DISTINCT ID_USUARIO, NOME, IDADE FROM TB_USUARIO ORDER BY IDADE");

    print(usuarios);
  }

  _buscarUsuario(int id) async{
    Database bd = await _recuperarBancoDados();

    List usuario = await bd.query(
      "TB_USUARIO",
      columns: ["ID_USUARIO", "NOME", "IDADE"],
      where: "ID_USUARIO = ?",
      whereArgs: [id]
    );

    print(usuario);
  }

  _removerUsuario(int id) async {
    Database bd = await _recuperarBancoDados();

    int usuariosRemovidos = await
    bd.delete(
      "TB_USUARIO",
      where: "ID_USUARIO = ?",
      whereArgs: [id]
    );

    print(usuariosRemovidos);

  }

  _atualizarUsuario(int id, Map<String, dynamic> usuario) async {
    Database bd = await _recuperarBancoDados();

    bd.update(
      "TB_USUARIO",
      usuario,
      where: "ID_USUARIO = ?",
      whereArgs: [id]);
  }


  @override
  Widget build(BuildContext context) {

    Map<String, dynamic> usuario = {
      "NOME": "Quim Sharqlebolt",
      "IDADE":  999,
    };

    _atualizarUsuario(12, usuario);
    _listarUsuario();

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
