import 'package:flutter/material.dart';
import 'package:note/database/sqflite.dart';
import 'package:note/object/NoteObject.dart';

class NoteScreen extends StatelessWidget {
  final NoteObject? note;
  final Function? onChanged;

  const NoteScreen({Key? key, this.note,  this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameNoteController = TextEditingController();
    final contentNoteController = TextEditingController();

    if (note != null) {
      nameNoteController.text = note?.nameNote ??"";
      contentNoteController.text = note!.contentNote;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(note == null ? 'Add a note' : 'Edit note'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: TextFormField(
                controller: nameNoteController,
                maxLines: 1,
                decoration: const InputDecoration(
                    hintText: 'nameNote',
                    labelText: 'Input nameNote',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 12.75,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ))),
              ),
            ),
            TextFormField(
              controller: contentNoteController,
              decoration: const InputDecoration(
                  hintText: 'Type here the note',
                  labelText: 'Input contentNote',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 0.75,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ))),
              keyboardType: TextInputType.multiline,
              onChanged: (str) {},
              maxLines: 5,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () async {
                      final nameNote = nameNoteController.value.text;
                      final contentNote = contentNoteController.value.text;

                      if (contentNote.isEmpty) {
                        return;
                      }

                      final NoteObject model = NoteObject(
                          id: note?.id,
                          nameNote: nameNote,
                          contentNote: contentNote,
                        check: note?.check??false,

                      );
                      if (note == null) {
                        await DatabaseHelper.insertNote(model);
                      } else {
                        await DatabaseHelper.updateNote(model);
                      }

                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                )))),
                    child: Text(
                      note == null ? 'Save' : 'Edit',
                      style: const TextStyle(fontSize: 20),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
