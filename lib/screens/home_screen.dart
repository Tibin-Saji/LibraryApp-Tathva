import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:library_app/firebase_functions.dart';
import 'package:library_app/screens/book_details_screen.dart';
import 'package:library_app/services/auth.dart';
import 'package:library_app/widgets.dart';

import '../globals.dart';
import 'my_library.dart';

// Map<String, List<Books>> bookTypes = {};

List<Books> bestSellerList = [];
List<Books> recentList = [];
bool isLoading = false;
AuthService _auth = AuthService();

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _getBooks() async {
    setState(() {
      isLoading = true;
    });
    bestSellerList =
        await getBooks(field: 'Tags', isEqualto: false, value: 'Bestseller');
    recentList =
        await getBooks(field: 'Tags', isEqualto: false, value: 'Recent');
    setState(() {
      isLoading = false;
    });
  }

  // TODO: make the book carousel more dynamic
  // Future<void> _getAllTypeBooks() async {
  //   var tags = await getBookTags();
  //   for (var tag in tags) {
  //     bookTypes[tag] =
  //         await getBooks(field: 'Tags', isEqualto: false, value: tag);
  //   }
  // }

  @override
  void initState() {
    _getBooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: TextCustom(
          'NERDY',
          //weight: FontWeight.w900,
          size: 25,
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextButton(
                onPressed: () async {
                  await _auth.signOut();
                },
                child: TextSmall('Logout'),
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.library_add_rounded),
        foregroundColor: Colors.black,
        backgroundColor: Colors.grey,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyLibraryScreen()),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            // TextField(
            //   onChanged: (str) {},
            //   decoration: InputDecoration(
            //       border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(30)),
            //       hintText: 'Search for book'),
            // ),
            const SizedBox(
              height: 16,
            ),
            TextCustom(
              "Best Seller",
              size: 30,
            ),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : CarouselSlider.builder(
                    itemCount: bestSellerList.length,
                    itemBuilder: (context, index, realIndex) {
                      final image = InkWell(
                        child: Image.network(bestSellerList[index].imgUrl),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BookDetailsScreen(
                                    book: bestSellerList[index])),
                          );
                        },
                      );
                      return image;
                    },
                    options: CarouselOptions(
                      viewportFraction: 0.4,
                      height: 175,
                      autoPlay: false,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                    )),
            const SizedBox(
              height: 16,
            ),
            TextCustom(
              "Recent",
              size: 30,
            ),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : CarouselSlider.builder(
                    itemCount: recentList.length,
                    itemBuilder: (context, index, realIndex) {
                      final image = InkWell(
                        child: Image.network(recentList[index].imgUrl),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BookDetailsScreen(book: recentList[index])),
                          );
                        },
                      );
                      return image;
                    },
                    options: CarouselOptions(
                      viewportFraction: 0.4,
                      height: 175,
                      autoPlay: false,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                    )),
          ],
        ),
      ),
    );
  }
}

// Widget BookCarousel(String tag) {
//   return Column(
//     children: [
//       const SizedBox(
//         height: 16,
//       ),
//       TextCustom(
//         tag,
//         size: 30,
//       ),
//       isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : CarouselSlider.builder(
//               itemCount: bestSellerList.length,
//               itemBuilder: (context, index, realIndex) {
//                 final image = InkWell(
//                   child: Image.network(bestSellerList[index].imgUrl),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) =>
//                               BookDetailsScreen(book: bestSellerList[index])),
//                     );
//                   },
//                 );
//                 return image;
//               },
//               options: CarouselOptions(
//                 viewportFraction: 0.4,
//                 height: 175,
//                 autoPlay: false,
//                 enlargeCenterPage: true,
//                 enlargeStrategy: CenterPageEnlargeStrategy.height,
//               )),
//     ],
//   );
// }
