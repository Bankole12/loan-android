import 'package:mongo_dart/mongo_dart.dart';
import 'package:crypt/crypt.dart';
import 'package:pisto/models/local_db_models.dart';
import 'package:pisto/services/local_db_helper.dart';

class AuthService {
  // String _eml;
  // String _pass;

  // AuthService(this._eml, this._pass);
  // Db db = Db('mongodb://10.0.2.2:27017/Pristo');

  Future<Map<String, dynamic>> login(String eml, String pass) async {
    Map<String, dynamic> result;
    Db mdb;
    try {
      // db = Db('mongodb://10.0.2.2:27017/Pristo');
      mdb = await Db.create(
          'mongodb+srv://pristouser:pristopass@simoncluster.3v5oy.mongodb.net/Pristo?retryWrites=true&w=majority');
      await mdb.open();

      DbCollection userCollection = mdb.collection('users');
      var user = await userCollection.findOne(where.eq('email', eml));
      // print(user['role']);

      if (user == null)
        result = {'error': 'Account Not Found'};
      else {
        final hashPass = Crypt((user['password']).toString());

        if (!hashPass.match(pass))
          result = {'error': 'Invalid Password'};
        else {
          await userCollection
              .update(await userCollection.findOne(where.eq('email', eml)), {
            r'$set': {'islogin': 'true', 'logindate': new DateTime.now()}
          });
          user['islogin'] = 'true';
          result = user;
        }
      }
    } catch (e) {
      result = {'error': 'Error occurred. Please try again'};
    }
    if (mdb != null) await mdb.close();
    return result;
  }

  Future<int> logout(String eml, String id) async {
    int result = 0;
    Db mdb;
    try {
      // mdb = Db('mongodb://10.0.2.2:27017/Pristo');
      LocalDatabaseHelper db = LocalDatabaseHelper.instance;
      mdb = await Db.create(
          'mongodb+srv://pristouser:pristopass@simoncluster.3v5oy.mongodb.net/Pristo?retryWrites=true&w=majority');
      await mdb.open();

      DbCollection userCollection = mdb.collection('users');
      await userCollection
          .update(await userCollection.findOne(where.eq('email', eml)), {
        r'$set': {'islogin': 'false'}
      });

      await db.userLogout(id);

      result = 1;
    } catch (e) {
      result = 0;
    }
    if (mdb != null) await mdb.close();
    return result;
  }

  Future<Map<String, dynamic>> signup(data) async {
    print('signup-data: ' + data.toString());
    Map<String, dynamic> result;
    Db mdb;
    try {
      Map<String, dynamic> _newData = {
        'name': data['firstname'] + " " + data['lastname'],
        'email': data['email'],
        'role': data['role'],
        'password': Crypt.sha512(data['password']).toString(),
        'picture': '',
        'islogin': 'false',
        'logindate': '',
        'loans': [],
        'stamp': new DateTime.now()
      };
      // print(_newData);
      // db = Db('mongodb://10.0.2.2:27017/Pristo');
      mdb = await Db.create(
          'mongodb+srv://pristouser:pristopass@simoncluster.3v5oy.mongodb.net/Pristo?retryWrites=true&w=majority');
      await mdb.open();

      DbCollection userCollection = mdb.collection('users');
      var user =
          await userCollection.findOne(where.eq('email', _newData['email']));

      if (user != null) {
        result = {'error': 'Email already exist. Recover password instead.'};
      }

      print('inserting data');
      user = await userCollection.insertOne(_newData);
      if (user != null) {
        result = {'success': 'ok'};
      }
    } catch (e) {
      print(e);
      result = {'error': 'Error occured. Please try again.'};
    }
    if (mdb != null) await mdb.close();
    return result;
  }
}

class LoanService {
  // String _eml;
  // String _pass;

  // AuthService(this._eml, this._pass);
  // Db mdb = Db('mongodb://10.0.2.2:27017/Pristo');
  Db mdb;

  Future<List> getAllLoans() async {
    List _loans = [];
    List _newLoans;
    // int _totUsers = 0,
    //     _totLoans = 0,
    //     _totPendingLoans = 0,
    //     _totApproveLoans = 0,
    //     _totCancelledLoans = 0;

    try {
      // mdb = Db('mongodb://10.0.2.2:27017/Pristo');
      mdb = await Db.create(
          'mongodb+srv://pristouser:pristopass@simoncluster.3v5oy.mongodb.net/Pristo?retryWrites=true&w=majority');
      await mdb.open();

      DbCollection userCollection = mdb.collection('users');
      var users = await userCollection.find().toList();

      if (users != null) {
        users.forEach((user) {
          _loans.add(user['loans']);
        });
        _newLoans = _loans.expand((loan) => loan).toList();
      }
    } catch (e) {
      print(e);
    }

    // Map<String, dynamic> dashData = {
    //   'users': _totUsers,
    //   'loans': _totLoans,
    //   'pending': _totPendingLoans,
    //   'approved': _totApproveLoans,
    //   'cancelled': _totCancelledLoans,
    //   'userslist': _usersList
    // };

    // print(_newLoans);
    if (mdb != null) await mdb.close();
    return _newLoans;
  }

  Future<int> sendRequest() async {
    int result = 0;
    LocalDatabaseHelper db = LocalDatabaseHelper.instance;
    UserLoginModel userLoginModel = await db.getUser();
    LoanRequestModel loanRequestModel = await db.getLoanRequest();

    Map<String, dynamic> data = loanRequestModel.modelToMap();
    data['id'] = ObjectId.fromHexString(data['id']);
    // print("loan data: " + data.toString());

    String userId = userLoginModel.id;
    data.addAll(<String, dynamic>{
      'userId': ObjectId.parse(userId),
      'status': 'pending',
      'stamp': new DateTime.now()
    });
    // print("final data: " + data.toString());
    // final hashPass = Crypt((data['password']).toString()).toString();
    // print(hashPass);

    // mdb = Db('mongodb://10.0.2.2:27017/Pristo');
    mdb = await Db.create(
        'mongodb+srv://pristouser:pristopass@simoncluster.3v5oy.mongodb.net/Pristo?retryWrites=true&w=majority');
    await mdb.open();

    DbCollection userCollection = mdb.collection('users');
    Map<String, dynamic> row = await userCollection.update({
      '_id': ObjectId.parse(userId)
    }, {
      r'$push': {'loans': data}
    });
    // print(row);
    if (row != null) result = 1;

    // if (user == null)
    //   result = {'error': 'Account Not Found'};
    // else {
    //   final hashPass = Crypt((user['password']).toString());

    //   if (!hashPass.match(pass))
    //     result = {'error': 'Invalid Password'};
    //   else {
    //     await userCollection.update(await userCollection.findOne(where.eq('email', eml)), {
    //       r'$set': {'isLogin': 'true', 'loginDate':new DateTime.now()}
    //     });
    //     user['isLogin'] = 'true';
    //     result = user;
    //   }
    // }
    if (mdb != null) await mdb.close();
    // result = {'error': 'Account Not Found'};

    return result;
  }

  Future<int> updateLoanStatus(data) async {
    print("update-data: " + data.toString());
    //  mdb = Db('mongodb://10.0.2.2:27017/Pristo');
    int result = 0;
    mdb = await Db.create(
        'mongodb+srv://pristouser:pristopass@simoncluster.3v5oy.mongodb.net/Pristo?retryWrites=true&w=majority');
    await mdb.open();

    DbCollection userCollection = mdb.collection('users');

    Map<String, dynamic> row = await userCollection.update({
      '_id': data['userId'],
      'loans.id': data['loanId']
    }, {
      r'$set': {r'loans.$.status': data['status']}
    });
    // print(row);
    if (row != null) result = 1;

    return result;
  }
}

class DashBoardService {
  Db mdb;

  Future<Map<String, dynamic>> getDashData() async {
    List _usersList = [];
    int _totUsers = 0,
        _totLoans = 0,
        _totPendingLoans = 0,
        _totApproveLoans = 0,
        _totCancelledLoans = 0;

    try {
      // mdb = Db('mongodb://10.0.2.2:27017/Pristo');
      mdb = await Db.create(
          'mongodb+srv://pristouser:pristopass@simoncluster.3v5oy.mongodb.net/Pristo?retryWrites=true&w=majority');
      await mdb.open();

      DbCollection userCollection = mdb.collection('users');
      var users = await userCollection.find().toList();

      if (users != null) {
        _totUsers = users.length;

        users.forEach((user) {
          List loans = user['loans'];
          if (loans.isNotEmpty) {
            _totLoans += loans.length;
            loans.forEach((loan) {
              if (loan['status'] == 'pending')
                _totPendingLoans += 1;
              else if (loan['status'] == 'approved')
                _totApproveLoans += 1;
              else if (loan['status'] == 'cancelled') _totCancelledLoans += 1;
            });
          }

          user.remove('loans');
          _usersList.add(user);
        });
      }
    } catch (e) {
      print(e);
    }

    Map<String, dynamic> dashData = {
      'users': _totUsers,
      'loans': _totLoans,
      'pending': _totPendingLoans,
      'approved': _totApproveLoans,
      'cancelled': _totCancelledLoans,
      'userslist': _usersList
    };

    // print(dashData);
    if (mdb != null) await mdb.close();
    return dashData;
  }
}
