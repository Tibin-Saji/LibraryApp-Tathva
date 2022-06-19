import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:library_app/services/auth.dart';
import 'globals.dart';

Future<List<Books>> getBooks(
    {String value = '', String field = '', bool isEqualto = false}) async {
  List<Books> books = [];

  final ref = FirebaseFirestore.instance.collection('Books');
  final docs = field == ''
      ? await ref.get()
      : isEqualto
          ? await ref.where(field, isEqualTo: value).get()
          : await ref.where(field, arrayContains: value).get();
  final docList = docs.docs;

  for (QueryDocumentSnapshot doc in docList) {
    Books book = Books(
        name: doc['Name'] as String,
        id: doc['Id'] as String,
        authorName: doc['Author'] as String,
        imgUrl: doc['Image'] as String,
        rating: doc['Rating'] as double,
        feedbacks: doc['Feedbacks'],
        tags: doc['Tags'],
        desc: doc['Description'] as String);
    books.add(book);
  }
  return books;
}

Future<List<Books>> getFavouriteBooks() async {
  List<dynamic> favBooks = await getFavourites();

  List<Books> books = [];

  for (var bId in favBooks) {
    var booksList = await getBooks(field: 'Id', isEqualto: true, value: bId);
    books.add(booksList[0]);
  }

  return books;
}

Future<bool> updateFavourites(String bId) async {
  List<dynamic> favBooks = await getFavourites();
  if (favBooks.contains(bId)) {
    return false;
  }
  favBooks.add(bId);

  AuthService _auth = AuthService();
  UserDB db = UserDB(uid: _auth.currentUser?.uid);

  // updateUserData() works when only one field is there for user.
  // Create another function if multiple fields are there.
  db.updateUserData(favBooks);

  return true;
}

Future<List<dynamic>> getFavourites() async {
  AuthService _auth = AuthService();
  var uid = _auth.currentUser?.uid;

  var userDetails =
      await FirebaseFirestore.instance.collection('Users').doc(uid).get();
  return userDetails['Favourites'];
}

Future<List> getBookTags() async {
  var doc = await FirebaseFirestore.instance
      .collection('Misc')
      .doc('Constants')
      .get();
  return doc['Tags'];
}

class UserDB {
  final String? uid;
  UserDB({required this.uid});
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');

  Future updateUserData(List<dynamic> bookIds) async {
    return await userCollection.doc(uid).set({'Favourites': bookIds});
  }
}
