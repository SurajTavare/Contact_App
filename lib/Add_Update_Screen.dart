import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class addUpadteScreen extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController numberController;
  final VoidCallback onAdd;
   final VoidCallback onCancel;
  final bool isUpdating;


   const addUpadteScreen({
    super.key,
    required this.numberController,
    required this.nameController,
     required this.onAdd,
     required this.onCancel,
     required this.isUpdating,
  });

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text( isUpdating? "Update Contact" : " New Contact"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: "Enter Name ",
              prefixIcon: Icon(Icons.person),
              prefixIconColor: Colors.blue,
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: numberController,
            maxLength: 10,
            textInputAction: TextInputAction.done,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Enter Number",
              prefixIcon: Icon(Icons.phone),
              prefixIconColor: Colors.blueAccent,
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.purple,
          ),
          onPressed: onAdd,
          child: Text(isUpdating ? "Update" : "Add"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.red,
          ),
          onPressed: onCancel,
          child: Text("Cancel"),
        ),
      ],
    );
  }
}
