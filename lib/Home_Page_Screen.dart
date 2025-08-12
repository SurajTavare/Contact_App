import 'package:contact_app/phone_list_screen.dart';
import 'package:flutter/material.dart';

import 'favourite_contact_page.dart';

class HomePageScreen extends StatefulWidget {
   HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int currentPage=0;

  List<Widget>pages=[
    ContactListPage(),
    favContactPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Contacts ",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: pages[currentPage] ,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value){
          setState(() {
            currentPage=value;
          });
        },
        currentIndex: currentPage,
        iconSize: 35,
        selectedItemColor: Colors.red,
        selectedLabelStyle: TextStyle(fontSize: 0),
        unselectedLabelStyle: TextStyle(fontSize: 0),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.contacts), label: ""),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_rounded),
            label: "",
          ),
        ],
      ),
    );
  }
}
