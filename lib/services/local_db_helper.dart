import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:pisto/models/local_db_models.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseHelper {
  static final _dbName = 'Pisto.db';
  static final _dbVersion = 1;

  LocalDatabaseHelper._privateConstructor();
  static final LocalDatabaseHelper instance =
      LocalDatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _dbName);

    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.transaction((txn) async {
      await txn.execute('''CREATE TABLE user (
          id TEXT PRIMARY KEY NOT NULL,
          name TEXT NOT NULL,
          email TEXT NOT NULL,
          role TEXT NOT NULL,
          picture TEXT,
          islogin BOOLEAN NOT NULL DEFAULT false,
          logindate TEXT NOT NULL
          )             
    ''');

      await txn.execute('''CREATE TABLE loanrequest (
          id TEXT PRIMARY KEY,
          requestedamount Text NOT NULL DEFAULT '',
          repaymentdays TEXT NOT NULL DEFAULT '',
          interestrate TEXT NOT NULL DEFAULT '', 
          repayamount  TEXT NOT NULL DEFAULT '',
          repaydate TEXT NOT NULL DEFAULT '',
          promocode TEXT NOT NULL DEFAULT '',
          firstname TEXT NOT NULL DEFAULT '',
          lastname TEXT NOT NULL DEFAULT '',
          gender TEXT NOT NULL DEFAULT '',
          dateofbirth TEXT NOT NULL DEFAULT '',
          idnumber TEXT NOT NULL DEFAULT '',
          password TEXT NOT NULL DEFAULT '',
          email TEXT NOT NULL DEFAULT '',
          phone TEXT NOT NULL DEFAULT '',
          region TEXT NOT NULL DEFAULT '',
          city TEXT NOT NULL DEFAULT '',
          street TEXT NOT NULL DEFAULT '',
          houseaddress TEXT NOT NULL DEFAULT '',
          idfront TEXT NOT NULL DEFAULT '',
          idback TEXT NOT NULL DEFAULT '',
          idselfie TEXT NOT NULL DEFAULT ''
          )
    ''');

      await txn.execute('''CREATE TABLE loans (
          id TEXT PRIMARY KEY,
          requestedamount Text NOT NULL DEFAULT '',
          repaymentdays TEXT NOT NULL DEFAULT '',
          interestrate TEXT NOT NULL DEFAULT '', 
          repayamount  TEXT NOT NULL DEFAULT '',
          repaydate TEXT NOT NULL DEFAULT '',
          promocode TEXT NOT NULL DEFAULT '',
          firstname TEXT NOT NULL DEFAULT '',
          lastname TEXT NOT NULL DEFAULT '',
          gender TEXT NOT NULL DEFAULT '',
          dateofbirth TEXT NOT NULL DEFAULT '',
          idnumber TEXT NOT NULL DEFAULT '',
          password TEXT NOT NULL DEFAULT '',
          email TEXT NOT NULL DEFAULT '',
          phone TEXT NOT NULL DEFAULT '',
          region TEXT NOT NULL DEFAULT '',
          city TEXT NOT NULL DEFAULT '',
          street TEXT NOT NULL DEFAULT '',
          houseaddress TEXT NOT NULL DEFAULT '',
          idfront TEXT NOT NULL DEFAULT '',
          idback TEXT NOT NULL DEFAULT '',
          idselfie TEXT NOT NULL DEFAULT '',
          status TEXT NOT NULL DEFAULT '',
          stamp TEXT NOT NULL DEFAULT ''
          )
    ''');
    });
  }

  Future<void> userLogin(UserLoginModel user) async {
    // print("loans: " + user.loans.length.toString());
    Database db = await database;
    await db.insert('user', user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    user.loans.forEach((element) async {
      element['id'] = element['id'].toHexString().toString();
      element['stamp'] = element['stamp'].toString();
      element.remove('userId');
      await db.insert('loans', element,
          conflictAlgorithm: ConflictAlgorithm.replace);
    });
  }

  Future<void> userLogout(String id) async {
    // print("loans: " + user.loans.length.toString());
    print('logout-id: ' + id);
    Database db = await database;
    try {
      int r =
          await db.rawDelete('DELETE FROM user WHERE id = ?', [id]);
      print('r: ' + r.toString());
    } catch (e) {
      print(e);
    }
  }

  Future<UserLoginModel> getUser() async {
    Database db = await database;
    List<Map> maps = await db.rawQuery('SELECT * FROM user');
    if (maps.length > 0) {
      return UserLoginModel.fromNap(maps.first);
    }
    return null;
  }

  Future<List> getAllLoans() async {
    Database db = await database;
    List maps = await db.rawQuery('SELECT * FROM loans');
    return maps;
  }

  Future<LoanRequestModel> getLoanRequest() async {
    Database db = await database;
    List<Map> maps = await db.rawQuery('SELECT * FROM loanrequest');
    // print("maps.length: " + maps.length.toString());
    // print("maps: " + maps.toString());
    if (maps.length > 0) {
      return LoanRequestModel.fromNap(maps.first);
    }
    return null;
  }

  Future<int> insertLoanRequest(LoanRequestModel loanreq) async {
    Database db = await database;
    int id = await db.insert('loanrequest', loanreq.lrqToMap());
    return id;
  }

  Future<int> updateLoanRequest(LoanRequestModel loanreq) async {
    Database db = await database;
    int id = await db.update('loanrequest', loanreq.lrqToMap());
    return id;
  }

  Future<int> updatePersonalInfo(LoanRequestModel loanreq) async {
    Database db = await database;
    int id = await db.update('loanrequest', loanreq.psfToMap());
    return id;
  }

  Future<int> updateAddressInfo(LoanRequestModel loanreq) async {
    Database db = await database;
    int id = await db.update('loanrequest', loanreq.addrToMap());
    return id;
  }

  Future<int> updateIdInfo(LoanRequestModel loanreq) async {
    Database db = await database;
    int id = await db.update('loanrequest', loanreq.idvToMap());
    return id;
  }

  Future<int> deleteLoanReq() async {
    Database db = await database;
    int id = await db.delete('loanrequest', where: 'id = ?', whereArgs: [1]);
    return id;
  }
}
