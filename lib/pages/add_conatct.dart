import 'dart:io';

import 'package:contact_dairy/main.dart';
import 'package:flutter/material.dart';

import '../contact_models.dart';
import 'package:image_picker/image_picker.dart';

class AddContact extends StatefulWidget {
  const AddContact({Key? key}) : super(key: key);

  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final _picker = ImagePicker();

  String? image;

  final GlobalKey<FormState> _addContactFormKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String? firstName;
  String? lastName;
  String? phone;
  String? email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add",
          // style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              // color: Colors.black,
            )),
        actions: [
          IconButton(
            onPressed: () {
              if (_addContactFormKey.currentState!.validate()) {
                _addContactFormKey.currentState!.save();

                // print(firstName);
                // print(lastName);
                // print(phone);
                // print(email);
                // contact.firstName = firstName!;
                // contact.lastName = lastName!;
                // contact.phone = phone!;
                // contact.email = email!;
                Contact myContact = Contact(
                    firstName: firstName,
                    lastName: lastName,
                    phone: phone,
                    email: email,
                    image: File(image!));
                contacts.add(myContact);
                Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
              }
            },
            icon: const Icon(
              Icons.check,
              // color: Colors.black,
            ),
          ), //check
        ],
        elevation: 1,
        // backgroundColor: Colors.white,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 2,
            ),
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 55,
                    backgroundImage:
                        (image != null) ? FileImage(File(image!)) : null,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        (image == null)
                            ? const Text(
                                "ADD",
                                style: TextStyle(color: Colors.black),
                              )
                            : Container(),
                        Align(
                          alignment: const Alignment(1.2, 1.2),
                          child: FloatingActionButton(
                            mini: true,
                            onPressed: () async {
                              XFile? xFile = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              setState(() {
                                image = xFile!.path;
                              });
                            },
                            child: const Icon(Icons.add),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            Expanded(
              flex: 6,
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  child: Form(
                      key: _addContactFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextFormField(
                            controller: _firstNameController,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter your first name...";
                              }
                              return null;
                            },
                            onSaved: (val) {
                              setState(() {
                                firstName = val;
                              });
                            },
                            decoration: const InputDecoration(
                              label: Text("First Name"),
                              hintText: ("Enter your first name here"),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: _lastNameController,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter your last name...";
                              }
                              return null;
                            },
                            onSaved: (val) {
                              setState(() {
                                lastName = val;
                              });
                            },
                            decoration: const InputDecoration(
                              label: Text("Last Name"),
                              hintText: ("Enter your last name here"),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: _phoneController,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter your phone number...";
                              } else if (val.length != 10) {
                                return "Enter valid number length...";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            onSaved: (val) {
                              setState(() {
                                phone = val;
                              });
                            },
                            decoration: const InputDecoration(
                              label: Text("Phone Number"),
                              hintText: ("Enter your phone number here"),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: _emailController,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter your email...";
                              }
                              return null;
                            },
                            onSaved: (val) {
                              setState(() {
                                email = val;
                              });
                            },
                            decoration: const InputDecoration(
                              label: Text("Email"),
                              hintText: ("Enter your email here"),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
