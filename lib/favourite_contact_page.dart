import 'package:contact_app/DBHelper.dart';
import 'package:flutter/material.dart';

class favContactPage extends StatefulWidget {
  const favContactPage({super.key});

  @override
  State<favContactPage> createState() => _favContactPageState();
}

class _favContactPageState extends State<favContactPage> {
  List<Map<String, dynamic>> favContacts = [];
  DBHelper? myDB;

  getFavContacts() async {
    favContacts = await myDB!.getFavContacts();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myDB = DBHelper.getInstacnce;
    getFavContacts();
  }

  @override
  Widget build(BuildContext context) {
    print(favContacts);
    return Scaffold(
      body: favContacts.isNotEmpty
          ? ListView.builder(
              itemCount: favContacts.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.all(6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: Colors.blue.shade50,
                  child: ListTile(
                    trailing: IconButton(
                      onPressed: () {
                        myDB!.UpdatingFavContact(
                          "false",
                          (favContacts[index]['id']).toString(),
                        );
                        getFavContacts();
                      },
                      icon: favContacts[index]['favourite'] == "true"
                          ? Icon(Icons.star, color: Colors.blue, size: 30)
                          : Icon(Icons.star_border_outlined, size: 30),
                    ),
                    title: Text(favContacts[index]['name']),
                    subtitle: Text(favContacts[index]['number']),
                  ),
                );
              },
            )
          : Center(
              child: Text(
                "No Favourite Contact Yet",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
    );
  }
}
