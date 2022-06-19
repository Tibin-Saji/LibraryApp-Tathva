import 'package:flutter/material.dart';
import 'package:library_app/globals.dart';
import 'package:library_app/widgets.dart';

import '../firebase_functions.dart';
import 'book_details_screen.dart';

List<Books> books = [];

class MyLibraryScreen extends StatefulWidget {
  const MyLibraryScreen({Key? key}) : super(key: key);

  @override
  State<MyLibraryScreen> createState() => _MyLibraryScreenState();
}

class _MyLibraryScreenState extends State<MyLibraryScreen> {
  bool isLoading = true;

  @override
  void initState() {
    getFavBooks();
    super.initState();
  }

  Future getFavBooks() async {
    setState(() {
      isLoading = true;
    });

    books = await getFavouriteBooks();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text("My Library"),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: books.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BookDetailsScreen(book: books[index])),
                      );
                    },
                    child: Row(
                      children: [
                        Image.network(
                          books[index].imgUrl,
                          scale: 1.5,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextMedium(books[index].name),
                            TextSmall(books[index].authorName)
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
