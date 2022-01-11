import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:passwordmanager/acman.dart';
import 'package:passwordmanager/viewpage.dart';
import 'package:path_provider/path_provider.dart';
import 'config.dart';
import 'dbclass/hivedb.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(PData());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List adata = [];
  awidget(index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewPage(adata: adata[index]),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Config.tilesColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Text(
                adata[index].aname,
                style: TextStyle(
                    color: Config.textcolor,
                    fontFamily: "Montserrat",
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () async {
            var updatedvalue = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Acman(
                  editmode: true,
                  evalues: adata[index],
                ),
              ),
            );
            if (updatedvalue != null) {
              Box<ClassDB> box = await Hive.openBox<ClassDB>('classes');
              box.putAt(index, updatedvalue);
              setState(() {
                adata = box.values.toList();
              });
            }
          },
          child: const Icon(
            Icons.edit_outlined,
            size: 25,
            color: Colors.teal,
          ),
        ),
        TextButton(
          onPressed: () async {
            Box<ClassDB> box = await Hive.openBox<ClassDB>('classes');
            box.deleteAt(index);
            setState(() {
              adata = box.values.toList();
            });
          },
          child: Icon(
            Icons.delete_outline_rounded,
            size: 25,
            color: Colors.red[300],
          ),
        ),
      ],
    );
  }

  getdata() async {
    Box<ClassDB> box = await Hive.openBox<ClassDB>('classes');
    setState(() {
      adata = box.values.toList();
    });
  }

  @override
  void initState() {
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    bool dtheme = MediaQuery.of(context).platformBrightness == Brightness.light
        ? true
        : false;
    Config.changeColor(dtheme);
    return Scaffold(
      backgroundColor: Config.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Text(
              'Your Accounts',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Config.textcolor,
                fontFamily: 'Montserrat',
                fontSize: 30,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: adata.length,
                itemBuilder: (BuildContext context, int index) =>
                    awidget(index),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Config.textcolor,
        foregroundColor: Config.backgroundColor,
        onPressed: () async {
          var value = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Acman(editmode: false),
            ),
          );
          if (value != null) {
            Box<ClassDB> box = await Hive.openBox<ClassDB>('classes');
            box.add(value);
            setState(() {
              adata = box.values.toList();
            });
          }
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
