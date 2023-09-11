import 'package:mysql1/mysql1.dart';

import '../core/database/database.dart';
import '../core/exceptions/email_already_registered.dart';
import '../core/exceptions/user_notfound_exception.dart';
import '../core/helpers/cripty_helper.dart';
import '../entities/user.dart';

class UserRepository {
  Future<User> login(String email, String password) async {
    MySqlConnection? conn;
    try {
      conn = await Database().openConnection();
      await Future.delayed(Duration(seconds: 1));

      final result = await conn.query('''
      select * from usuario
      where email = ?
      and senha = ?
      ''', [email, CriptyHelper.generatedSha256Hash(password)]);

      if (result.isEmpty) {
        throw UserNotfoundException();
      }
      final userData = result.first;

      return User(
        id: userData['id'],
        name: userData['nome'],
        email: userData['email'],
        password: '',
      );
    } on MySqlException catch (e, s) {
      print(e);
      print(s);
      throw Exception('Erro ao realizar login');
    } finally {
      await conn?.close();
    }
  }

  Future<void> save(User user) async {
    MySqlConnection? conn;
    try {
      conn = await Database().openConnection();
      await Future.delayed(Duration(seconds: 1));
      final isUserRegister = await conn
          .query('select * from usuario where email = ? ', [user.email]);
      if (isUserRegister.isEmpty) {
        await conn.query('''
        insert into usuario
        values(?,?,?,?)
        ''', [
          null,
          user.name,
          user.email,
          CriptyHelper.generatedSha256Hash(user.password),
        ]);
      } else {
        throw EmailAlreadyRegistered();
      }
    } on MySqlException catch (e, s) {
      print(e);
      print(s);
      throw Exception();
    } finally {
      await conn?.close();
    }
  }

  Future<User> findById(int id) async {
    MySqlConnection? conn;
    try {
      conn = await Database().openConnection();
      await Future.delayed(Duration(seconds: 1));

      final result =
          await conn.query('select * from usuario where id = ?', [id]);
      final mysqlData = result.first;

      return User(
        id: mysqlData['id'],
        name: mysqlData['nome'],
        email: mysqlData['email'],
        password: '',
      );
    } on MySqlException catch (e, s) {
      print(e);
      print(s);
      throw Exception();
    } finally {
      await conn?.close();
    }
  }
}



// // //
// // //




// class UserRepository {
//   Future<User> login(String email, String password) async {
//     MySqlConnection? conn;
//     try {
//       conn = await Database().openConnection();
//       final result = await conn.query(''' 
//           select * from usuario
//           where email = ?
//           and senha = ?
//          ''', [email, CriptyHelper.generatedSha256Hash(password)]);

//       if (result.isEmpty) {
//         throw UserNotfoundException();
//       }

//       final userData = result.first;

//       return User(
//         id: userData['id'],
//         name: userData['nome'],
//         email: userData['email'],
//         password: '',
//       );
//     } on MySqlException catch (e, s) {
//       print(e);
//       print(s);
//       throw Exception('Erro ao realizar login');
//     } finally {
//       await conn?.close();
//     }
//   }

//   Future<void> save(User user) async {
//     MySqlConnection? conn;
//     try {
//       conn = await Database().openConnection();

//       final isUserRegiser = await conn
//           .query('select * from usuario where email = ? ', [user.email]);

//       if (isUserRegiser.isEmpty) {
//         await conn.query(''' 
//           insert into usuario
//           values(?,?,?,?)
//         ''', [
//           null,
//           user.name,
//           user.email,
//           CriptyHelper.generatedSha256Hash(user.password)
//         ]);
//       } else {
//         throw EmailAlreadyRegistered();
//       }
//     } on MySqlException catch (e, s) {
//       print(e);
//       print(s);
//       throw Exception();
//     } finally {
//       await conn?.close();
//     }
//   }

//   Future<User> findById(int id) async {
//     MySqlConnection? conn;
//     try {
//       conn = await Database().openConnection();
//       final result =
//           await conn.query('select * from usuario where id = ?', [id]);
//       final mysqlData = result.first;
//       return User(
//         id: mysqlData['id'],
//         name: mysqlData['nome'],
//         email: mysqlData['email'],
//         password: '',
//       );
//     } on MySqlException catch (e, s) {
//       print(e);
//       print(s);
//       throw Exception();
//     } finally {
//       await conn?.close();
//     }
//   }
// }

// /// ////
// // /// //


// class UserRepository {
//   Future<User> login(String email, String password) async {
//     MySqlConnection? conn;
//     try {
//       conn = await Database().openConnection();
//       await Future.delayed(Duration(seconds: 1));

//       final result = await conn.query('''
//       select from * usuario
//       where email = ?
//       and senha = ?
//       ''', [email, CriptyHelper.generatedSha256Hash(password)]);

//       if (result.isEmpty) {
//         throw UserNotfoundException();
//       }
//       final userData = result.first;

//       return User(
//         id: userData['id'],
//         name: userData['nome'],
//         email: userData['email'],
//         password: '',
//       );
//     } on MySqlException catch (e, s) {
//       print(e);
//       print(s);
//       throw Exception('Erro ao realizar login');
//     } finally {
//       await conn?.close();
//     }
//   }

//   Future<void> save(User user) async {
//     MySqlConnection? conn;
//     try {
//       conn = await Database().openConnection();
//       await Future.delayed(Duration(seconds: 1));
//       final isUserRegister = await conn
//           .query('select * from usuario where email = ? ', [user.email]);
//       if (isUserRegister.isEmpty) {
//         await conn.query(''' 
//         insert into usuario
//         values(?,?,?,?)
//         ''', [
//           null,
//           user.name,
//           user.email,
//           CriptyHelper.generatedSha256Hash(user.password),
//         ]);
//       } else {
//         throw EmailAlreadyRegistered();
//       }
//     } on MySqlException catch (e, s) {
//       print(e);
//       print(s);
//       throw Exception();
//     } finally {
//       await conn?.close();
//     }
//   }

//   Future<User> findById(int id) async {
//     MySqlConnection? conn;
//     try {
//       conn = await Database().openConnection();
//       await Future.delayed(Duration(seconds: 1));

//       final result =
//           await conn.query('select * from usuario where id = ?', [id]);
//       final mysqlData = result.first;

//       return User(
//         id: mysqlData['id'],
//         name: mysqlData['nome'],
//         email: mysqlData['email'],
//         password: '',
//       );
//     } on MySqlException catch (e, s) {
//       print(e);
//       print(s);
//       throw Exception();
//     } finally {
//       await conn?.close();
//     }
//   }
// }
