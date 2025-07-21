import 'package:flutter/material.dart';
import 'package:note/database/sqflite.dart';
import 'package:note/object/NoteObject.dart';
import 'package:note/screen/note_screen.dart';
import 'package:note/widget/note_widget.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(backgroundColor: Colors.amber,
          title: const Text('Note'),
          centerTitle: true,
          foregroundColor: Colors.black,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(context,
                MaterialPageRoute(builder: (context) => const NoteScreen()));
            setState(() {});
          },backgroundColor: Colors.amber,
          child: const Icon(Icons.add),
        ),
        body: Column(
          children: [
            const Align(alignment: Alignment.centerLeft,child: Text("Impotant",style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic))),
            Expanded(
              flex: 1,
              child: FutureBuilder<List<NoteObject>?>(
                future: DatabaseHelper.getAllNotestrue(),
                builder: (context, AsyncSnapshot<List<NoteObject>?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      return GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                        itemBuilder: (context, index) => NoteWidget(
                          note: snapshot.data![index],
                          onTap: () async {
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NoteScreen(
                                      note: snapshot.data![index],
                                    )));
                            setState(() {});
                          },
                          onLongPress: () async {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text(
                                        'Are you sure you want to delete this note?'),
                                    actions: [
                                      ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red)),
                                        onPressed: () async {
                                          await DatabaseHelper.deleteNote(
                                              snapshot.data![index]);
                                          Navigator.pop(context);
                                          setState(() {});
                                        },
                                        child: const Text('Yes'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('No'),
                                      ),
                                    ],
                                  );
                                });
                          },
                        ),
                        itemCount: snapshot.data!.length,
                      );
                    }
                    return const Center(
                      child: Text('No notes yet'),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            const Divider(
              thickness: 1,
              color: Colors.grey,
            ),            const Align(alignment: Alignment.centerLeft,child: Text("Uninpotant",style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)) ),
            Expanded(
              flex: 2,
              child: FutureBuilder<List<NoteObject>?>(
                future: DatabaseHelper.getAllNotesfalse(),
                builder: (context, AsyncSnapshot<List<NoteObject>?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      return GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                        itemBuilder: (context, index) => NoteWidget(
                          note: snapshot.data![index],
                          onTap: () async {
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NoteScreen(
                                      note: snapshot.data![index],
                                    )));
                            setState(() {});
                          },
                          onLongPress: () async {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text(
                                        'Are you sure you want to delete this note?'),
                                    actions: [
                                      ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red)),
                                        onPressed: () async {
                                          await DatabaseHelper.deleteNote(
                                              snapshot.data![index]);
                                          Navigator.pop(context);
                                          setState(() {});
                                        },
                                        child: const Text('Yes'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('No'),
                                      ),
                                    ],
                                  );
                                });
                          },
                        ),
                        itemCount: snapshot.data!.length,
                      );
                    }
                    return const Center(
                      child: Text('No notes yet'),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),

          ],
        )
    );
  }
}
