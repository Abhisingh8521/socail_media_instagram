// import 'dart:io';
// import 'package:baat_cheet_app/views/utils/constants.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
//
// class DatabaseHelper {
//   /// GROWER TABLE KEYS
//   static const TABLE_GROWER = 'grower';
//   static const CODE_GROWER = 'code_grower';
//   static const NAME_GROWER = 'name_grower';
//   static const ADDRESS_GROWER = 'address_grower';
//   static const ID_GROWER = "id_grower";
//
//   /// QC TABLE KEYS
//   static const TABLE_QC = "table_qc";
//   static const ID_QC = "id_qc";
//   static const LOT_NO_QC = 'lot_no_qc';
//   static const CROP_CODE_QC = 'crop_code_qc';
//   static const NAME_QC = 'name_qc';
//   static const VERIFY_QC = 'verify_qc';
//   static const ITEM_QC = 'item_qc';
//
//   /// GOT SOWING
//   static const TABLE_SOWING = "got_sowing";
//   static const ID_SOWING = "id_sowing";
//   static const ID_QC_SOWING = "id_qc";
//   static const ID_GROWER_SOWING = "id_grower";
//   static const DATE_OF_PLANTING_SOWING = "date_of_planting";
//
//   DatabaseHelper._constructor();
//
//   static final instanceDb = DatabaseHelper._constructor();
//   static Database? _database;
//
//   Future<Database?> get database async {
//     if (_database != null) return _database;
//     _database = await _initDatabase();
//     return _database;
//   }
//
//   _initDatabase() async {
//     Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     String path = documentsDirectory.path + DATABASE_NAME;
//     return await openDatabase(path,
//         version: DATABASE_VERSION, onCreate: _createDatabase);
//   }
//
//   Future _createDatabase(Database db, int version) async {
//     await db.execute('''
//     CREATE TABLE $TABLE_GROWER (
//     $ID_GROWER INTEGER PRIMARY KEY,
//     $NAME_GROWER TEXT NOT NULL,
//     $CODE_GROWER TEXT NOT NULL,
//     $ADDRESS_GROWER TEXT NOT NULL
//     )
//     ''');
//
//     await db.execute('''
//           CREATE TABLE $TABLE_QC (
//             $ID_QC INTEGER PRIMARY KEY,
//             $LOT_NO_QC TEXT NOT NULL,
//             $CROP_CODE_QC TEXT NOT NULL,
//             $NAME_QC TEXT NOT NULL,
//             $VERIFY_QC TEXT NOT NULL,
//             $ITEM_QC TEXT NOT NULL
//           )
//           ''');
//
//     await db.execute('''
//     CREATE TABLE $TABLE_SOWING (
//     $ID_SOWING INTEGER PRIMARY KEY,
//       $ID_QC_SOWING TEXT NOT NULL,
//       $ID_GROWER_SOWING TEXT NOT NULL,
//       $DATE_OF_PLANTING_SOWING TEXT NOT NULL,
//       $NAME_GROWER TEXT NOT NULL,
//       $CODE_GROWER TEXT NOT NULL,
//       $ADDRESS_GROWER TEXT NOT NULL,
//       $LOT_NO_QC TEXT NOT NULL,
//       $CROP_CODE_QC TEXT NOT NULL,
//       $NAME_QC TEXT NOT NULL,
//       $VERIFY_QC TEXT NOT NULL,
//       $ITEM_QC TEXT NOT NULL
//        )''');
//   }
//
//   Future<int?> insertData(Map<String, dynamic> data, String tableName) async {
//     Database? db = await instanceDb.database;
//     return await db?.insert(tableName, data);
//   }
//
//   Future<int> insertDataBulk(List<Map> data, String tableName) async {
//     Database? db = await instanceDb.database;
//     Batch? batch = db?.batch();
//     for (var element in data) {
//       batch?.insert(tableName, element as Map<String, Object?>);
//     }
//     batch?.commit();
//     return 1;
//   }
//
//   Future<int?> updateData(Map<String, dynamic> data, String tableName,
//       String key, dynamic value) async {
//     Database? db = await instanceDb.database;
//     return await db
//         ?.update(tableName, data, where: "$key = ?", whereArgs: [value]);
//   }
//
//   Future<int?> deleteData(String tableName, String key, dynamic value) async {
//     Database? db = await instanceDb.database;
//     return await db
//         ?.rawDelete('''DELETE FROM $tableName WHERE $key = $value''');
//   }
//
//   Future<int?> deleteTable(String tableName) async {
//     Database? db = await instanceDb.database;
//     return await db?.delete(tableName);
//   }
//
//   Future<List?> getSingleDataOfColumn(String tableName, String key) async {
//     Database? db = await instanceDb.database;
//     return await db?.query(tableName, columns: [key]);
//   }
//
//   Future<List<Map<String, dynamic>>?> getSingleData(
//       String tableName, String key, dynamic value) async {
//     Database? db = await instanceDb.database;
//     return await db?.query(tableName, where: "$key = ?", whereArgs: [value]);
//   }
//
//   Future<List<Map<String, dynamic>>?> getAllData(String tableName) async {
//     Database? db = await instanceDb.database;
//     return await db?.query(tableName);
//   }
// }
