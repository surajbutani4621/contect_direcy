import 'dart:async';

import 'package:contact_dairy/pages/add_conatct.dart';
import 'package:contact_dairy/pages/detail_page.dart';
import 'package:contact_dairy/pages/edit_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../contact_models.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ContactDairy(),
  );
}

bool isDark = false;

class ContactDairy extends StatefulWidget {
  const ContactDairy({Key? key}) : super(key: key);

  @override
  _ContactDairyState createState() => _ContactDairyState();
}

class _ContactDairyState extends State<ContactDairy> {

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(milliseconds: 100),(val){
      setState(() {

      });
    });
  }
  final ThemeData _lightTheme = ThemeData(primaryColor:  Colors.white,
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(color: Colors.black),
    ),
    iconTheme: const IconThemeData(color: Colors.black),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.lightBlue,
      foregroundColor: Colors.white,
    ),
  );
  final ThemeData _darkTheme = ThemeData(primaryColor:  Colors.black,
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      titleTextStyle: TextStyle(color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold),
      iconTheme:  IconThemeData(color: Colors.white),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.lightBlue,
      foregroundColor: Colors.white,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _lightTheme,
      darkTheme: _darkTheme,
      themeMode: (isDark == false)?ThemeMode.light:ThemeMode.dark,
      routes: {
        '/': (context) => const HomePage(),
        'add_contact': (context) => const AddContact(),
        'edit_page': (context) => const EditContact(),
        'detail_page': (context) => const DetailPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: backGroundColor,
      appBar: AppBar(
        title: const Text(
          "Contacts",
        ),
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                isDark = !isDark;
              });
            },
            // child: CircleAvatar(
            //   radius: 16,
            //   backgroundColor: Colors.grey.withOpacity(0.5),
            child: CircleAvatar(
              backgroundColor: Theme.of(context).appBarTheme.titleTextStyle!.color,
              radius: 12,
              // ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
        elevation: 1,
        // backgroundColor: appBarColor,
      ),
      body: (contacts.isEmpty)
          ? Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:const  [
            // SizedBox(height: 30,),
            Icon(
              Icons.home,
              size: 100,
              // color: iconColor,
            ),
            SizedBox(
              height: 30,
            ),
            SelectableText(
              "You have no contacts yet",
              // style: TextStyle(color: Colors.grey, fontSize: 22),
            ),
          ],
        ),
      )
          : ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, i) {
          return ListTile(
            onTap: (){
              Navigator.of(context).pushNamed("detail_page",arguments: contacts[i]);
            },
            leading: CircleAvatar(
              radius: 26,
              backgroundImage: (contacts[i].image != null)
                  ? FileImage(contacts[i].image)
                  : null,
            ),
            title: Text(
              "${contacts[i].firstName} ${contacts[i].lastName}",
              // style: TextStyle(color: nameText),
            ),
            subtitle: Text(
              "+91 ${contacts[i].phone}",
              style: const TextStyle(color: Colors.grey),
            ),
            trailing: IconButton(
                onPressed: () async {
                  String url = "tel:+91${contacts[i].phone}";
                  if (await canLaunch(url)) {
                    await launch(url);
                    bool? res =
                    await FlutterPhoneDirectCaller.callNumber(url);
                  }
                },
                icon: const Icon(
                  Icons.call,
                  color: Colors.green,
                  size: 33,
                )),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("add_contact");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

