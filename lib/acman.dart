import 'package:flutter/material.dart';
import 'package:passwordmanager/config.dart';
import 'package:passwordmanager/dbclass/hivedb.dart';

class Acman extends StatefulWidget {
  final bool editmode;
  final ClassDB? evalues;
  const Acman({Key? key, required this.editmode, this.evalues}) : super(key: key);

  @override
  _AcmanState createState() => _AcmanState();
}

class _AcmanState extends State<Acman> {
  final FocusNode _af = FocusNode();
  final FocusNode _uf = FocusNode();
  final FocusNode _pf = FocusNode();
  final TextEditingController _ac = TextEditingController();
  final TextEditingController _uc = TextEditingController();
  final TextEditingController _pc = TextEditingController();
  textf(focs, cont, hint, cap) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      height: 50,
      padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
      decoration: BoxDecoration(
        color: Config.tilesColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: TextField(
        textCapitalization: cap,
        textInputAction: TextInputAction.go,
        focusNode: focs,
        onEditingComplete: () {
          focs.nextFocus();
        },
        style: TextStyle(
          color: Config.textcolor,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        controller: cont,
        decoration: InputDecoration(
          counterText: "",
          hintText: hint,
          border: InputBorder.none,
          hintStyle: TextStyle(
            color: Colors.grey.shade500,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.evalues != null) {
      setState(() {
        _ac.text = widget.evalues!.aname!;
        _uc.text = widget.evalues!.uname!;
        _pc.text = widget.evalues!.paswd!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          textf(_af, _ac, "Enter account name", TextCapitalization.words),
          textf(_uf, _uc, "Enter username", TextCapitalization.none),
          textf(_pf, _pc, "Enter password", TextCapitalization.none),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 5, left: 10),
                  child: MaterialButton(
                    elevation: 0,
                    padding: const EdgeInsets.all(10),
                    color: Config.textcolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    onPressed: () {
                      ClassDB data = ClassDB()
                        ..aname = _ac.text
                        ..uname = _uc.text
                        ..paswd = _pc.text;
                      Navigator.pop(context, data);
                    },
                    child: Text(
                      'Done',
                      style: TextStyle(
                        color: Config.backgroundColor,
                        fontFamily: 'Montserrat',
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, left: 5),
                  child: MaterialButton(
                    elevation: 0,
                    padding: const EdgeInsets.all(10),
                    color: Config.textcolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Config.backgroundColor,
                        fontFamily: 'Montserrat',
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
