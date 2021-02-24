import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notebook/model/client.dart';
import 'package:notebook/screens/show_screen.dart';
import 'package:notebook/utils/change_screen.dart';
import 'package:notebook/utils/color.dart';
import 'package:notebook/utils/margin.dart';
import 'package:notebook/utils/responsive.dart';
import 'package:notebook/view_model/note.dart';

import 'rectangle_note.dart';

class NoteComponents extends StatelessWidget {
  final ChangeNotifierProvider<Note> noteR;
  final Note note;
  final NoteModel noteModel;

  const NoteComponents({Key key, this.noteModel, this.note, this.noteR})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        return Container(
          child: Material(
            child: InkWell(
              splashColor: Colors.yellow,
              onTap: () => note.marking
                  ? note.addToMarked(noteModel.id)
                  : changeScreen(
                      context,
                      ShowScreen(
                        index: noteModel.id,
                        noteR: noteR,
                      )),
              onLongPress: () {
                if (!note.marking) {
                  note.changeMarkedAll();
                  note.addToMarked(noteModel.id);
                  print(note.marked);
                }
                print(note.marked);

                print(note.marking);
              },
              child: Container(
                child: Row(
                  children: [
                    NoteBlock(index: noteModel.categoryNum),
                    XMargin(Responsive.screenWidth(5, context)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            noteModel.description,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: Responsive.textSize(4.5, context),
                              height: Responsive.textSize(.5, context),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                noteModel.category,
                                style: TextStyle(
                                  height: Responsive.textSize(.5, context),
                                  fontSize: Responsive.textSize(4, context),
                                  color: categoryColor(noteModel.categoryNum),
                                ),
                              ),
                              XMargin(Responsive.screenWidth(3.5, context)),
                              Text(
                                // "Date",
                                "${noteModel.date.toLocal().day.toString()}/${noteModel.date.toLocal().month}/${noteModel.date.toLocal().year.toString()}",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    height: Responsive.textSize(.5, context),
                                    fontSize: Responsive.textSize(4, context)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    XMargin(Responsive.screenWidth(3.5, context)),
                    note.marking && note.marked.contains(noteModel.id)
                        ? Icon(
                            Icons.check_circle,
                            color: Colors.yellow[900],
                          )
                        : note.marking
                            ? Icon(
                                Icons.check_circle_outline,
                              )
                            : Text(""),
                    XMargin(Responsive.screenWidth(2.5, context)),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
