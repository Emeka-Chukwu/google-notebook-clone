import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notebook/model/client.dart';
import 'package:notebook/utils/margin.dart';
import 'package:notebook/utils/responsive.dart';
import 'package:notebook/view_model/note.dart';
import 'package:notebook/widgets/create_body.dart';
import 'package:notebook/widgets/header_create.dart';

import '../inject_riverpod.dart';

// final noteR = Provider<Note>((ref) => Note());
// final noteR = ChangeNotifierProvider<Note>((ref) => Note());
final noteR = noteRR;
final controller = TextEditingController();

class CreateNote extends StatelessWidget {
  final NoteModel noteModel;

  CreateNote({this.noteModel});

  @override
  Widget build(BuildContext context) {
    // controller.text = "";
    // print(controller.text);
    // print("value be null");
    controller.text = "";
    controller.text = noteModel?.description ?? "";
    return Scaffold(
      body: Consumer(
        builder: (context, watch, child) {
          final add = watch(noteR);
          void getTheCategory(int index) {
            print(" here  index $index");
            add.changeIndex(index);
            noteModel?.categoryNum = add.index;
            print(add.index);
          }

          print(noteModel?.category);
          if (noteModel?.category == null) {
            if (!add.runTheGetCategory) {
              getTheCategory(1);
              add.changeTheCategory();
            }
          }
          if (noteModel?.categoryNum != null) {
            getTheCategory(noteModel?.categoryNum);
          }

          return Container(
            child: Column(
              children: [
                CreateHeader(
                  cancel: () => Navigator.pop(context),
                  save: () {
                    if (noteModel != null) {
                      if (controller.text.isEmpty) {
                        getTheCategory(1);
                        print("herer   gg");
                        Navigator.pop(context, "Note Saved");
                        return;
                      }
                      noteModel.category = add.categories[add.index - 1];
                      noteModel.categoryNum = add.index;
                      noteModel.description = controller.text;
                      noteModel.date = DateTime.now();
                      noteModel.dateTime = DateTime.now().toString();
                      add.updateNoteToDb(noteModel);
                    } else {
                      if (controller.text.isEmpty) {
                        getTheCategory(1);
                        Navigator.pop(context, "Empty note is not created");
                        // add.changeTheCategory();
                        return;
                      }
                      NoteModel createModel = NoteModel(
                        description: controller.text,
                        category: add.categories[add.index - 1],
                        categoryNum: add.index,
                        date: DateTime.now(),
                        dateTime: DateTime.now().toString(),
                      );
                      // print(createModel.category);
                      // print(createModel.description);
                      // print(createModel.categoryNum);
                      // print(createModel.date);
                      add.addNoteToDb(createModel);
                    }
                    Navigator.pop(context, "Note Saved");
                    // getTheCategory(1);
                    add.changeTheCategory();
                  },
                ),
                // CreateBody(),
                YMargin(10),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Responsive.screenWidth(4, context)),
                  child: TextField(
                    controller: controller,
                    cursorColor: Colors.yellow[900],
                    style: TextStyle(
                        fontSize: Responsive.textSize(4.6, context),
                        height: Responsive.textSize(.45, context)),
                    decoration: InputDecoration(border: InputBorder.none),
                    maxLines: 40,
                  ),
                )),
                Container(
                  padding: EdgeInsets.only(
                      bottom: Responsive.screenHeight(1.5, context)),
                  child: RowCategory(
                    index: noteModel?.categoryNum ?? add.index,
                    onTap: getTheCategory,
                    note: noteR,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
