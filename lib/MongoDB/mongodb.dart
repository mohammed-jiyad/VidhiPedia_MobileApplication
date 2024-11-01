import 'package:vidhipedia/MongoDB/constant.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'dart:developer';
class MongoDatabase {

  static late Db _db;

  // Connect to the database
  static Future<void> connect() async {
    _db = await Db.create(MONGO_URL);
    await _db.open();
    inspect(_db);
    var status = await _db.serverStatus();
    print(status);
  }
  static Future<bool> emailExists(String email) async {
    // Replace this with your actual database query logic
    // For example:
    var result = await _db.collection('users').findOne({'email': email});
    return result != null;
  }
  // Insert user data
  static Future<void> addFieldToUser(String? email, int studypath) async {
    var collection = _db.collection('users');

    await collection.updateOne(
        where.eq('email', email), // Find the document by email
        modify.set('studypath', studypath)
        // Add the new field
    );
  }


  static Future<void> insertUser(Map<String, dynamic> userData) async {
    var collection = _db.collection(COLLECTION_NAME);

    // Insert the user data and get the result
    var result = await collection.insertOne(userData);

    // Access the generated ObjectId
    userData['_id'] = userData['email']; // Convert ObjectId to String

    // Print the inserted document and the generated _id
    print("User inserted: $userData");

  }
  static Future<Map<String, dynamic>?> findUser(String email, String password) async {
    var collection = _db.collection(COLLECTION_NAME);
    return await collection.findOne({
      'email': email,
      'password': password,
    });
  }

}