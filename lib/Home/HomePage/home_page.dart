import 'package:flutter/material.dart';
import 'package:flutter_app/Home/Model/productc.dart';
import 'package:flutter_app/SignIn/SignInPage/sign_in_page.dart';

class HomePage extends StatefulWidget {
  static String routeName = "HomePage";

  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Products> myProductsList;
  bool isListView = false;

  @override
  void initState() {
    myProductsList = getProductsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Our Products"),
          actions: [
            InkWell(
                onTap: () {
                  setState(() {
                    isListView = !isListView;
                  });
                },
                child: Icon(Icons.view_agenda_outlined)),
            SizedBox(
              width: 6,
            ),
            InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Logout"),
                          content: Text("Do you want to logout?"),
                          actions: [
                            Row(
                              children: [
                                TextButton(
                                  child: Text("No"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text("Yes"),
                                  onPressed: () {
                                    Navigator.popAndPushNamed(
                                        context, SignInPage.routeName);
                                  },
                                ),
                              ],
                            )
                          ],
                        );
                      });
                },
                child: Icon(Icons.more_vert)),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        body: isListView ? buildListView() : buildGridView());
  }

  Widget buildListView() {
    return ListView.builder(
        itemCount: myProductsList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 10,
              child: Row(
                children: [
                  Card(
                    child: Image.asset(
                      myProductsList[index].imageUrl,
                      width: MediaQuery.of(context).size.width / 2,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        myProductsList[index].name,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "\u20B9 ${myProductsList[index].price}",
                        style: TextStyle(
                            color: Colors.black87, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Shop Now",
                        style: TextStyle(
                            color: Colors.black87, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget buildGridView() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: myProductsList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              clipBehavior: Clip.antiAlias,
              elevation: 10,
              child: Column(
                children: [
                  Expanded(
                    child: Image.asset(
                      myProductsList[index].imageUrl,
                      fit: BoxFit.fitHeight,
                      width: double.infinity,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Center(
                    child: Text(
                      myProductsList[index].name,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Center(
                    child: Text(
                      "\u20B9 ${myProductsList[index].price}",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
