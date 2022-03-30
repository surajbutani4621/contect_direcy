import 'dart:io';

import 'package:contact_dairy/main.dart';
import 'package:flutter/material.dart';

import '../contact_models.dart';
import 'package:image_picker/image_picker.dart';

class EditContact extends StatefulWidget {
  const EditContact({Key? key}) : super(key: key);

  @override
  _EditContactState createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  final _picker = ImagePicker();

  String? image;

  final GlobalKey<FormState> _editContactFormKey = GlobalKey<FormState>();

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
    dynamic args = ModalRoute
        .of(context)!
        .settings
        .arguments;
    _firstNameController.text = args.firstName;
    _lastNameController.text = args.lastName;
    _phoneController.text = args.phone;
    _emailController.text = args.email;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Contact",
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
              if (_editContactFormKey.currentState!.validate()) {
                _editContactFormKey.currentState!.save();

                Contact myContact = Contact(
                    firstName: firstName,
                    lastName: lastName,
                    phone: phone,
                    email: email,
                    image: (image != null) ? (File(image!)) : args.image,);

                int i = contacts.indexOf(args);
                contacts[i] = myContact;
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
                    FileImage(args.image!),
                    //     (image != null) ? FileImage(File(args.image!)) : null,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
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
                            child: const Icon(Icons.edit),
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
                      key: _editContactFormKey,
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
