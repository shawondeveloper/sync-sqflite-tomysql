import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:syncsqftomysql/contactinfomodel.dart';
import 'package:http/http.dart' as http;

import 'databasehelper.dart';

class Controller {
  final conn = SqfliteDatabaseHelper.instance;

  static Future<bool> isInternet()async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      if (await DataConnectionChecker().hasConnection) {
        print("Mobile data detected & internet connection confirmed.");
        return true;
      }else{
        print('No internet :( Reason:');
        return false;
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      if (await DataConnectionChecker().hasConnection) {
        print("wifi data detected & internet connection confirmed.");
        return true;
      }else{
        print('No internet :( Reason:');
        return false;
      }
    }else {
      print("Neither mobile data or WIFI detected, not internet connection found.");
      return false;
    }
  }

  Future<int> addData(ContactinfoModel contactinfoModel)async{
    var dbclient = await conn.db;
    int result;
    try {
      result = await dbclient.insert(SqfliteDatabaseHelper.contactinfoTable, contactinfoModel.toJson());
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future<int> updateData(ContactinfoModel contactinfoModel)async{
    var dbclient = await conn.db;
    int result;
    try {
      result = await dbclient.update(SqfliteDatabaseHelper.contactinfoTable, contactinfoModel.toJson(),where: 'id=?',whereArgs: [contactinfoModel.id]);
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future fetchData()async{
    var dbclient = await conn.db;
    List userList = [];
    try {
      List<Map<String,dynamic>> maps = await dbclient.query(SqfliteDatabaseHelper.contactinfoTable,orderBy: 'id DESC');
      for (var item in maps) {
        userList.add(item);
      }
    } catch (e) {
      print(e.toString());
    }
    return userList;
  }