import 'package:contact_app/DBHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import 'Add_Update_Screen.dart';

class ContactListPage extends StatefulWidget {
  ContactListPage({super.key});

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  DBHelper? myDB;
  bool isUpdating = false;

  List<Map<String, dynamic>> myContacts = [];

  void getContact() async {
    myContacts = await myDB!.getContacts();
    setState(() {});
  }

  _makeCall({required String number}) async {
  }

  bool validation({required String name, required String number}) {
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          width: 330,
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.warning_rounded),
              SizedBox(width: 10),
              Text(" Please Enter Name", style: TextStyle(fontSize: 15)),
            ],
          ),
        ),
      );
      return false;
    }
    if (number.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          width: 330,
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.warning_rounded),
              SizedBox(width: 10),
              Text(
                "Number should have 10 Digits",
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      );
      return false;
    }
    // if (num/ber.)
    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myDB = DBHelper.getInstacnce;
    getContact();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myContacts.isNotEmpty
          ? ListView.builder(
              itemCount: myContacts.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.all(5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.blue.shade50,
                  child: ListTile(
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () async {
                            await FlutterPhoneDirectCaller.callNumber(myContacts[index]['number']);
                          },
                          icon: Icon(Icons.call, color: Colors.green),
                        ),
                        IconButton(
                          onPressed: () {
                            myDB!.UpdatingFavContact(
                              "true",
                              (myContacts[index]['id']).toString(),
                            );
                            getContact();
                          },
                          icon: myContacts[index]['favourite'] == "false"
                              ? Icon(Icons.star_border_outlined)
                              : Icon(Icons.star, color: Colors.blue),
                        ),
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                isUpdating = true;
                                nameController.text = myContacts[index]['name'];
                                numberController.text =
                                    myContacts[index]['number'];
                                return addUpadteScreen(
                                  nameController: nameController,
                                  numberController: numberController,
                                  isUpdating: isUpdating,
                                  onAdd: () {
                                    if (validation(
                                      name: nameController.text,
                                      number: numberController.text,
                                    )) {
                                      myDB!.updateContact(
                                        nameController.text,
                                        numberController.text,
                                        (myContacts[index]['id']).toString(),
                                      );
                                      Navigator.pop(context);
                                    }
                                    getContact();
                                    isUpdating = false;
                                  },
                                  onCancel: () {
                                    nameController.clear();
                                    numberController.clear();
                                    isUpdating = false;
                                    getContact();
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            );
                          },
                          icon: Icon(Icons.edit, color: Colors.green, size: 25),
                        ),
                        IconButton(
                          onPressed: () {
                            myDB!.deleteContact(
                              id: (myContacts[index]['id']).toString(),
                            );
                            getContact();
                          },
                          icon: Icon(Icons.delete, color: Colors.red, size: 25),
                        ),
                      ],
                    ),
                    title: Text(myContacts[index]['name']),
                    subtitle: Text(myContacts[index]['number'].toString()),
                  ),
                );
              },
            )
          : Center(
              child: Text(
                "No Contact Yet",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.grey.shade500,
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              nameController.clear();
              numberController.clear();
              return addUpadteScreen(
                nameController: nameController,
                numberController: numberController,
                isUpdating: isUpdating,
                onAdd: () {
                  if (validation(
                    name: nameController.text,
                    number: numberController.text,
                  )) {
                    myDB!.addContact(
                      name: nameController.text,
                      number: numberController.text,
                    );
                  }
                  getContact();
                  Navigator.pop(context);
                },
                onCancel: () {
                  getContact();
                  Navigator.pop(context);
                },
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
