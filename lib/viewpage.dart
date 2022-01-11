import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'config.dart';
import 'dbclass/hivedb.dart';

class ViewPage extends StatefulWidget {
  final ClassDB adata;
  const ViewPage({Key? key, required this.adata}) : super(key: key);

  @override
  _ViewPageState createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.backgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            textw(
                widget.adata.aname, Config.textcolor, FontWeight.normal, 30.0),
            const Spacer(flex: 8),
            textw('Username', Colors.grey, FontWeight.normal, 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textw(widget.adata.uname, Config.textcolor, FontWeight.bold,
                    20.0),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: InkWell(
                    onTap: () {
                      Clipboard.setData(
                        ClipboardData(text: widget.adata.uname),
                      );
                    },
                    child: const Icon(
                      Icons.copy_rounded,
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            ),
            const Spacer(flex: 1),
            textw('Password', Colors.grey, FontWeight.normal, 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textw(widget.adata.paswd, Config.textcolor, FontWeight.bold,
                    20.0),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: InkWell(
                    onTap: () {
                      Clipboard.setData(
                        ClipboardData(text: widget.adata.paswd),
                      );
                    },
                    child: const Icon(
                      Icons.copy_rounded,
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            ),
            const Spacer(flex: 10),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Config.textcolor,
        foregroundColor: Config.backgroundColor,
        onPressed: () {
          Navigator.pop(context);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.done_rounded),
      ),
    );
  }
}
