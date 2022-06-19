import 'package:flutter/material.dart';
import 'package:library_app/firebase_functions.dart';
import 'package:library_app/widgets.dart';

import '../globals.dart';

class BookDetailsScreen extends StatefulWidget {
  BookDetailsScreen({Key? key, required this.book}) : super(key: key);

  Books book;

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: const Text("Details"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: ListView(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(widget.book.imgUrl),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      TextCustom(
                        widget.book.name,
                        size: 90,
                      ),
                      Text(widget.book.authorName)
                    ],
                  ),
                  IconButton(
                      onPressed: () async {
                        bool res = await updateFavourites(widget.book.id);
                        res
                            ? ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                content: Text("Added to Favourites"),
                              ))
                            : ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                content: Text("Already added to Favourites"),
                              ));
                      },
                      icon: const Icon(Icons.library_add_rounded))
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Text(widget.book.desc),
              const SizedBox(
                height: 15,
              ),
              TextCustom(
                'Feedback',
                size: 16,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: widget.book.feedbacks.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Text(widget.book.feedbacks[index]);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
