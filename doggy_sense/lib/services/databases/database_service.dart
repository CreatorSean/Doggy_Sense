import 'package:doggy_sense/services/databases/models/diary_model.dart';
import 'package:doggy_sense/services/databases/models/my_pet_model.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static late Database _database;

  static Future<Database?> get database async {
    _database = await initDB();
    return _database;
  }

  static initDB() async {
    Logger().i(await getDatabasesPath());
    String path = join(await getDatabasesPath(), 'StackingCone.db');

    //데이터 베이스를 리셋하고 싶을때 주석 지우고 다시시작
    //await deleteDatabase(path);

    //db가 존재하지 않으면 onCreate 함수 실행되어 table 생성
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(
          "CREATE TABLE MyPet(id INTEGER PRIMARY KEY AUTOINCREMENT, dogName TEXT, birth TEXT, gender INTEGER, img BLOB, age INT)");
      await db.execute(
          "CREATE TABLE Diary(id INTEGER PRIMARY KEY AUTOINCREMENT, dogId INTEGER, title TEXT, img BLOB, sentence TEXT, date INTEGER, FOREIGN KEY (dogId) REFERENCES MyPet (id))");
    }, onUpgrade: (db, oldVersion, newVersion) {});
  }

  // ========================= insert DB ==============================
  static Future<void> insertDB(model, String tablename) async {
    final db = await database;
    Logger().i('Insert $tablename DB');

    await db!.insert(
      tablename,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // ========================= delete DB ==============================
  static Future<void> deleteDB(model, String tablename) async {
    final db = await database;
    Logger().i('Delete DB');

    await db!.delete(
      tablename,
      where: "id = ?",
      whereArgs: [model.id],
    );
  }

  static Future<List<DiaryModel>> getDiarysByDogtId(int dogtId) async {
    final db = await database;
    Logger().i('Get GameRecords DB for patientId: $dogtId');

    final List<Map<String, dynamic>> maps = await db!.query(
      'Diary',
      where: 'dogId = ?',
      whereArgs: [dogtId],
    );

    return List.generate(maps.length, (index) {
      return DiaryModel(
        id: maps[index]["id"],
        dogId: maps[index]["dogId"],
        title: maps[index]["title"],
        img: maps[index]["img"],
        sentence: maps[index]["sentence"],
        date: maps[index]["date"],
      );
    });
  }

  static Future<List<MyPetModel>> getPetListDB() async {
    final db = await database;
    Logger().i('Get MyPet DB');

    final List<Map<String, dynamic>> maps = await db!.query('MyPet');

    return List.generate(maps.length, (index) {
      return MyPetModel(
        id: maps[index]["id"],
        dogName: maps[index]["dogName"],
        birth: maps[index]["birth"],
        gender: maps[index]["gender"],
        img: maps[index]["img"],
        age: maps[index]["age"],
      );
    });
  }

  static Future<List<DiaryModel>> getDiaryListDB() async {
    final db = await database;
    Logger().i('Get Diary DB');

    final List<Map<String, dynamic>> maps = await db!.query('Diary');

    return List.generate(maps.length, (index) {
      return DiaryModel(
        id: maps[index]["id"],
        dogId: maps[index]["dogId"],
        title: maps[index]["title"],
        img: maps[index]["img"],
        sentence: maps[index]["sentence"],
        date: maps[index]["date"],
      );
    });
  }

  static Future<List<MyPetModel>> getSelectedPet(dogId) async {
    final db = await database;
    Logger().i('Get SelectedPatient DB : $dogId');
    final List<Map<String, dynamic>> maps = await db!.query(
      'MyPet',
      where: 'id = ?',
      whereArgs: [dogId],
    );
    return List.generate(maps.length, (index) {
      return MyPetModel(
        id: maps[index]["id"],
        dogName: maps[index]["dogName"],
        birth: maps[index]["birth"],
        gender: maps[index]["gender"],
        img: maps[index]["img"],
        age: maps[index]["age"],
      );
    });
  }

  // ========================= update DB ==============================
  static Future<void> updatePetDB(MyPetModel pet) async {
    final db = await database;
    Logger().i('Update DB: ${pet.dogName}');
    await db!.update(
      "MyPet",
      pet.toMap(),
      where: "id = ?",
      whereArgs: [pet.id],
    );
  }
}
