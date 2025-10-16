
import 'app_database.dart';

class UserLocalDataSource {
  Future<void> addUser(String name) async {
    final db = await AppDatabase.getInstance();
    await db.insert('users', {'name': name});
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await AppDatabase.getInstance();
    return db.query('users');
  }
}
