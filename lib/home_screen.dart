import 'package:flutter/material.dart';
import 'package:news_app/const.dart';
import 'package:news_app/model.dart';
import 'package:news_app/news_api.dart';
import 'package:news_app/news_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<NewsApiModel>? newsList;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews().then((value) {
      setState(() {
        if (value.isNotEmpty) {
          newsList = value;
          isLoading = false;
        } else {
          print("List is Empty");
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: Color.fromARGB(255, 139, 7, 7), title: Text('News Today', ),),
        drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 143, 5, 5),
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
        backgroundColor: getColors[1],
        body: Container(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              
              isLoading
                  ? Container(
                      height: size.height / 20,
                      width: size.height / 20,
                      child: CircularProgressIndicator(),
                    )
                  : Expanded(
                      child: Container(
                        child: ListView.builder(
                          itemCount: newsList!.length,
                          itemBuilder: (context, index) {
                            return listItems(size, newsList![index]);
                          },
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listItems(Size size, NewsApiModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ReadingNews(
              model: model,
            ),
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(bottom: 10),
          width: size.width / 1.15,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.black),
          ),
          child: Column(
            children: [
              Container(
                height: size.height / 4,
                width: size.width / 1.05,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: Colors.black),
                  ),
                ),
                child: model.imageUrl != ""
                    ? Image.network(
                        model.imageUrl,
                        fit: BoxFit.cover,
                      )
                    : Text("Cant Load image"),
              ),
              Container(
                width: size.width / 1.1,
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  model.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                width: size.width / 1.1,
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  model.description,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
