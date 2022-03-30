import 'package:contact_dairy/contact_models.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute
        .of(context)!
        .settings
        .arguments;

    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Contacts",
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
          InkWell(
            onTap: () {
              setState(() {
                isDark = !isDark;
              });
            },
            // child: CircleAvatar(
            //   radius: 16,
            //   backgroundColor: Colors.grey.withOpacity(0.5),
              child:  CircleAvatar(
                backgroundColor: Theme.of(context).appBarTheme.titleTextStyle!.color,
                radius: 12,
              // ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
            // color: Colors.grey,
          ),
        ],
        elevation: 1,
        // backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Spacer(),
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey,
                    backgroundImage:
                    // FileImage(args.image),
                    (args.image != null) ? FileImage(args.image) : null,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    onPressed: () {
                      contacts.remove(args);

                      Navigator.of(context).pushReplacementNamed("/");
                    },
                    icon: const Icon(
                      Icons.delete,
                      size: 20,
                    ),
                  ),
                  // const SizedBox(width: 10,),

                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("edit_page",arguments: args);
                    }
                    ,
                    icon: const Icon(
                      Icons.edit,
                      size: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                "${args.firstName} ${args.lastName}",
                // style: const TextStyle(color: Colors.black, fontSize: 25),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "+91 ${args.phone}",
                    // style: const TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                color: Colors.black,
                thickness: 1,
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FloatingActionButton(
                    onPressed: () async {
                      if (await canLaunch("tel:+91 ${args.phone}")) {
                        await launch("tel:+91 ${args.phone}");
                      }
                    },
                    child: const Icon(
                      Icons.call,
                    ),
                    mini: true,
                    backgroundColor: Colors.green,
                  ),
                  FloatingActionButton(
                    onPressed: () async {
                      if (await canLaunch("sms:+91 ${args.phone}")) {
                        await launch("sms:+91 ${args.phone}");
                      }
                    },
                    child: const Icon(
                      Icons.message,
                    ),
                    mini: true,
                    backgroundColor: Colors.orangeAccent,
                  ),
                  FloatingActionButton(
                    onPressed: () async {
                      if (await canLaunch("mailto:" + args.email)) {
                        await launch("mailto:" + args.email);
                      }
                    },
                    child: const Icon(
                      Icons.email,
                    ),
                    mini: true,
                    backgroundColor: Colors.lightBlue,
                  ),
                  FloatingActionButton(
                    onPressed: () async {
                      // share any data
                     await Share.share(args.phone);
                    },
                    child: const Icon(
                      Icons.share,
                    ),
                    mini: true,
                    backgroundColor: Colors.deepOrangeAccent,
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const Divider(
                color: Colors.black,
                thickness: 1,
              ),
              const Spacer(
                flex: 4,
              ),
            ],
          ),
        ),
      ),

      // ),
    );
  }
}
