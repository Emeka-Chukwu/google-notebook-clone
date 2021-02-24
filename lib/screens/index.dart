import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notebook/inject_riverpod.dart';
import 'package:notebook/utils/change_screen.dart';
import 'package:notebook/utils/margin.dart';
import 'package:notebook/utils/responsive.dart';
import 'package:notebook/widgets/note_component.dart';
// import '../inject_riverpod.dart';
import "../services/pop_menu.dart";

import 'create_note.dart';

// final noteR = ChangeNotifierProvider<Note>((ref) => Note());
final noteR = noteRR;
// ChangeNotifierProvider<Note>

class IndexScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.yellow[900],
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Consumer(builder: (context, watch, child) {
      final noteRiver = watch(noteR);

      return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          leading: noteRiver.marking
              ? Padding(
                  padding: EdgeInsets.only(
                      right: Responsive.screenWidth(3.5, context)),
                  child: GestureDetector(
                    onTap: () => noteRiver.changeMarkedAll(),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                )
              : null,
          title: noteRiver.marking
              ? Text(
                  "${noteRiver.marked.length}/${noteRiver.noteModels.length}",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              : Text(
                  "Notebook",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
          actions: [
            noteRiver.marking
                ? noteRiver.marked.length == noteRiver.noteModels.length
                    ? GestureDetector(
                        onTap: () => noteRiver.markedAndUnMarkedAll(),
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.white,
                        ),
                      )
                    : GestureDetector(
                        onTap: () => noteRiver.markedAndUnMarkedAll(),
                        child: Icon(Icons.check_circle_outline,
                            color: Colors.white))
                : myPopMenu(noteRiver),
            XMargin(Responsive.screenWidth(2.5, context)),
          ],
        ),
        body: Container(
          child: Consumer(builder: (context, watch, child) {
            final noteRiverpod = watch(noteR);
            if (noteRiverpod.noteModels.isEmpty) {
              noteRiver.getAllDataFromDb();
            }
            return Stack(
              children: [
                Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          children: noteRiverpod.noteModels
                              .map(
                                (e) => NoteComponents(
                                  note: noteRiverpod,
                                  noteModel: e,
                                  noteR: noteR,
                                ),
                              )
                              .toList(),
                        ),
                        YMargin(Responsive.screenHeight(7, context))
                      ],
                    ),
                  ),
                ),
                if (noteRiverpod.marking && noteRiverpod.marked.length > 0)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: Responsive.screenHeight(1, context)),
                      width: double.infinity,
                      color: Colors.grey.withOpacity(.5),
                      child: GestureDetector(
                        onTap: () {
                          noteRiverpod.deleteNote(noteRiverpod.marked);
                          print("emeka");
                        },
                        child: Icon(
                          Icons.delete,
                          size: Responsive.textSize(7, context),
                          color: Colors.yellow[900],
                        ),
                      ),
                    ),
                  )
              ],
            );
          }),
        ),
        floatingActionButton: noteRiver.marking
            ? null
            : FloatingActionButton(
                focusColor: Colors.yellow[800],
                backgroundColor: Colors.yellow[800],
                onPressed: () =>
                    changeScreenWithResponse(context, CreateNote(), noteRiver),
                tooltip: 'Add Note',
                child: Icon(Icons.add),
              ),
      );
    });
  }
}
