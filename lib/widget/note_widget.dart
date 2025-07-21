import 'package:flutter/material.dart';
import 'package:note/database/sqflite.dart';
import 'package:note/main.dart';

import '../object/NoteObject.dart';
import '../screen/notes_screen.dart';

class NoteWidget extends StatefulWidget {

  final NoteObject note;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const NoteWidget(
      {Key? key,
      required this.note,
      required this.onTap,
      required this.onLongPress,
      })
      : super(key: key);

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {

  @override
  Widget build(BuildContext context)  {
    double linewith = (MediaQuery.of(context).size.width) / 50;
    double lineheight = (MediaQuery.of(context).size.height) / 30;
    bool? check = widget.note?.check??false;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 6),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Card(
          child: InkWell(
            onLongPress: widget.onLongPress,
            onTap: widget.onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    decoration: const BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5),
                            topLeft: Radius.circular(5))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: Row(

                        children: [
                          Expanded(

                            flex: 7,

                            child: Container(
                              height: lineheight.toDouble(),
                              alignment: Alignment.center,
                              child: Text(
                                widget.note?.nameNote ?? "",
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                                maxLines: 1,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child:Checkbox(
                                value: check,
                                checkColor: Colors.green,
                                activeColor: Colors.white,
                                onChanged: (value){

                                  check = value!;

                                  final NoteObject model = NoteObject(
                                    id: widget.note?.id,
                                    nameNote: widget.note.nameNote,
                                    contentNote: widget.note.contentNote,
                                    check: check??false,
                                  );
                                  DatabaseHelper.updateNoteCheck(model);

                                  setState(() {
                                    Navigator.pushReplacement(context,   MaterialPageRoute(builder: (context) => NotesScreen()),
                                    );
                                });
                                },


                                ),
                          )
                        ],
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black12,
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignOutside),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Text(
                        widget.note.contentNote,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400),
                        maxLines: linewith.toInt(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
