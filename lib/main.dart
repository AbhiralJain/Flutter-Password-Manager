import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:passwordmanager/acman.dart';
import 'package:path_provider/path_provider.dart';
import 'config.dart';
import 'dbclass/hivedb.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationDocumentsDirectory();
  Directory dir = Directory("${directory.path}/Passwords");
  if (!(dir.existsSync())) {
    await dir.create();
  }
  Hive.init(dir.path);

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
  int cindex = -1;
  textw(t, c, b, s) {
    return Text(
      t,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: c,
        fontFamily: 'Montserrat',
        fontWeight: b,
        fontSize: s,
      ),
    );
  }

  awidget(index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (cindex == index) {
            cindex = -1;
          } else {
            cindex = index;
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.all(5),
        padding: cindex == index ? const EdgeInsets.all(20) : const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Config.tilesColor,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: textw(adata[index].aname, Config.textcolor, FontWeight.bold, 20.0),
            ),
            if (cindex == index)
              Column(
                children: [
                  const Padding(padding: EdgeInsets.all(10)),
                  textw('Username', Colors.grey, FontWeight.normal, 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      textw(adata[index].uname, Config.textcolor, FontWeight.bold, 15.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: InkWell(
                          onTap: () {
                            Clipboard.setData(
                              ClipboardData(text: adata[index].uname),
                            );
                          },
                          child: const Icon(
                            Icons.copy_rounded,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.all(5)),
                  textw('Password', Colors.grey, FontWeight.normal, 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      textw(adata[index].paswd, Config.textcolor, FontWeight.bold, 15.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: InkWell(
                          onTap: () {
                            Clipboard.setData(
                              ClipboardData(text: adata[index].paswd),
                            );
                          },
                          child: const Icon(
                            Icons.copy_rounded,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.fromLTRB(5, 15, 5, 5)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                  )
                ],
              )
          ],
        ),
      ),
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
    bool dtheme = MediaQuery.of(context).platformBrightness == Brightness.light ? true : false;
    Config.changeColor(dtheme);
    return Scaffold(
      backgroundColor: Config.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 30),
              child: textw('Your Accounts', Config.textcolor, FontWeight.normal, 45.0),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: adata.length,
                itemBuilder: (BuildContext context, int index) => awidget(index),
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
        child: const Icon(Icons.add),
      ),
    );
  }
}
