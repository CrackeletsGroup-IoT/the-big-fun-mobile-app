import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase{
  final int version = 1;
  final String databaseName='events.db';
  final String tableName='events';

  Database? _db;//lo hacemos privado por que no se debe acceder desde fuera de la base de datos

  Future<Database> openDB() async{

    try{
      _db??=await openDatabase(
          join(await getDatabasesPath(),databaseName),
          onCreate: (database,version){
            database.execute('create table $tableName (id integer primary key, name text, address text, capacity integer, image text, date integer, cost integer, district text)');
          },
          version: version
      );
      print('La base de datos se abrió correctamente.');
      return _db as Database;
    }
    catch(e){
      print('Error al abrir la base de datos: $e');
      return Future.error('Error al abrir la base de datos: $e');
    }
  }
}