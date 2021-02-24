import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notebook/inject_riverpod.dart';
import 'package:notebook/utils/change_screen.dart';
import 'package:notebook/utils/color.dart';
import 'package:notebook/utils/margin.dart';
import 'package:notebook/utils/responsive.dart';
import 'package:notebook/view_model/note.dart';

import 'create_note.dart';

// final noteR = noteRR;

class ShowScreen extends StatelessWidget {
  final int index;
  final ChangeNotifierProvider<Note> noteR;

  const ShowScreen({Key key, this.index, this.noteR}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final note = watch(noteRR);
        var noteModel =
            note.noteModels.where((element) => element.id == index).toList()[0];
        return Scaffold(
          appBar: AppBar(
            brightness: Brightness.dark,
            elevation: 0,
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.pop(context)),
            title: Text(
              "Reading",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                right: Responsive.screenWidth(4.5, context),
                left: Responsive.screenWidth(4.5, context),
                top: Responsive.screenWidth(4.5, context),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        noteModel.category,
                        style: TextStyle(
                            color: categoryColor(noteModel.categoryNum),
                            height: Responsive.textSize(.5, context),
                            fontSize: Responsive.textSize(4, context)),
                      ),
                      XMargin(Responsive.screenWidth(4, context)),
                      Text(
                        // "yy"
                        "${noteModel.date.toLocal().day.toString()}/${noteModel.date.toLocal().month}/${noteModel.date.toLocal().year.toString()}",
                        style: TextStyle(
                            height: Responsive.textSize(.5, context),
                            fontSize: Responsive.textSize(4, context)),
                      )
                    ],
                  ),
                  YMargin(Responsive.screenWidth(1.5, context)),
                  Text(
                    noteModel.description,
                    style: TextStyle(
                        height: Responsive.textSize(.45, context),
                        fontSize: Responsive.textSize(4.5, context)),
                  )
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => changeScreenWithResponse(
              context,
              CreateNote(
                noteModel: noteModel,
              ),
              note,
            ),
            backgroundColor: Colors.yellow[900],
            child: Icon(Icons.edit, color: Colors.white),
          ),
        );
      },
    );
  }
}
