import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController saveController = TextEditingController();

// Globle Variable
  SharedPreferences? prefs;

  // Globle key
  String name_key = 'name';
  String count_key = 'count';

  String? name;

  int count = 0;

  @override
  void initState() {
    getValueFromPref();
    super.initState();
  }

// Colors Function
  Color getBGcolor() {
    //random Colors Find
    return Colors.primaries[Random().nextInt(Colors.primaries.length - 1)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: count % 3 == 0 ? getBGcolor() : Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home"),
      ),
      body: Column(
        children: [
          //get value
          Text('Welcome your last name saved was: ${name ?? 'Default'}'),
          TextField(
            controller: saveController,
          ),
          SizedBox(
            height: 11,
          ),
          count != 0
              ? Text(
                  "$count",
                  style: TextStyle(fontSize: 20),
                )
              : Container(),
          ElevatedButton(
              onPressed: () {
                //Set Value
                prefs!.setString(name_key, saveController.text);
              },
              child: Text("save")),
        ],
      ),
    );
  }

  void getValueFromPref() async {
    prefs = await SharedPreferences.getInstance();
    // not null ! than mark use
    name = prefs!.getString(name_key);
    count = prefs!.getInt(count_key) ?? 0;
    count++;
    prefs!.setInt(count_key, count);

    // setState data ui per Show karne k liya Use kiya hai
    setState(() {});
  }
}
