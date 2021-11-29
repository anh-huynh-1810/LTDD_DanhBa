import 'package:baitap9/contact_object.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ContactProvider {
  static Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'contact.db');
    Database db = await openDatabase(path, version: 1, onCreate: _oncreate);
    return db;
  }

  static void _oncreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE IF NOT EXISTS Contact( id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, phone TEXT NOT NULL )");
  }

  static Future<void> insertContact(ContactObject con) async {
    Database db = await initDatabase();
    db.insert('Contact', con.toMap());
  }

  static Future<List<ContactObject>> getAllContacts() async {
    List<ContactObject> lsResult = [];

    Database db = await initDatabase();
    List<Map<String, Object?>> ls = await db.query('Contact');
    lsResult = ls.map((e) => ContactObject.fromMap(e)).toList();
    return lsResult;
  }

  static Future<void> updateContact(ContactObject con) async {
    Database db = await initDatabase();
    final data = {'name': con.name, 'phone': con.phone};
    //final data = await initDatabase();
    await db.update('Contact', data, where: 'id = ?', whereArgs: [con.id]);
  }

  static Future<void> deleteContact(int id) async {
    Database db = await initDatabase();
    await db.delete('Contact', where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<ContactObject>> getContacts(int id) async {
    List<ContactObject> lsResult = [];

    Database db = await initDatabase();
    List<Map<String, Object?>> ls =
        await db.query('Contact', where: 'id = ?', whereArgs: [id]);
    lsResult = ls.map((e) => ContactObject.fromMap(e)).toList();
    return lsResult;
  }

  static Future<List<ContactObject>> searchContacts(String strSearch) async {
    List<ContactObject> lsResult = [];

    Database db = await initDatabase();
    List<Map<String, Object?>> ls = await db.query('Contact',
        where: 'name like ? or phone like',
        whereArgs: ['%$strSearch%', '%$strSearch%']);
    lsResult = ls.map((e) => ContactObject.fromMap(e)).toList();
    return lsResult;
  }
}
