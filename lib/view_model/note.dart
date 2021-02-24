import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notebook/model/client.dart';
import 'package:notebook/services/db.dart';
import 'package:notebook/utils/responsive.dart';

class Note extends ChangeNotifier {
  // List<NoteModel>  = List<NoteModel>();
  int index = 1;
  bool marking = false;
  bool runTheGetCategory = false;
  changeTheCategory() {
    runTheGetCategory = !runTheGetCategory;
  }

  void changeIndex(int catId) {
    index = catId;
    notifyListeners();
  }

  final List<NoteModel> noteModels = [];
  // noteModels = getAllDataFromDb();
  List<String> categories = [
    "Uncategorized",
    "Work",
    "Family Affairs",
    "Study",
    "Personal"
  ];

  List<int> marked = [];
  void clearMarked() {
    marked.clear();
    notifyListeners();
  }

  void markedAndUnMarkedAll() {
    if (marked.length == noteModels.length) {
      if (marked.length != 0) {
        marked.clear();
      }
    } else {
      marked.clear();

      marked.addAll(noteModels.map((e) => e.id).toList());
    }
    notifyListeners();
    print(marked);
  }

  void addToMarked(int id) {
    if (marked.contains(id)) {
      marked.remove(id);
    } else {
      marked.add(id);
    }

    notifyListeners();
  }

  void changeMarkedAll() {
    marking = !marking;
    marked.clear();
    notifyListeners();
  }

  void showToast(BuildContext context, String text, [Alignment align]) {
    showFlash(
      context: context,
      duration: const Duration(seconds: 2),
      builder: (context, controller) {
        return Flash.dialog(
          controller: controller,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          backgroundGradient: LinearGradient(
            colors: [Colors.blue, Colors.blue],
          ),
          alignment: align ?? Alignment.center,
          margin: const EdgeInsets.only(bottom: 48),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Responsive.screenWidth(5, context),
                vertical: Responsive.screenWidth(3, context)),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        );
      },
    );
  }

  NoteModel note = NoteModel();
  var demo = [
    NoteModel(
      id: 1,
      category: "work",
      categoryNum: 2,
      description:
          "this is the descroption of the not sha this is the descroption of the not sha",
      date: DateTime.now(),
    ),
    NoteModel(
      id: 2,
      category: "uncategorizeds",
      categoryNum: 1,
      description:
          "this is the descroption of the not sha this is the descroption of the not sha",
      date: DateTime.now(),
    ),
    NoteModel(
      id: 3,
      category: "family affairs",
      categoryNum: 3,
      description: "this is the descroption of the not sha",
      date: DateTime.now(),
    ),
    NoteModel(
      id: 4,
      category: "Study",
      categoryNum: 4,
      description:
          "this is the descroption of the not sha this is the descroption of the not sha",
      date: DateTime.now(),
    ),
    NoteModel(
      id: 5,
      category: "Personal",
      categoryNum: 5,
      description:
          "this is the descroption of the not shathis is the descroption of the not sha",
      date: DateTime.now(),
    ),
    NoteModel(
      id: 6,
      category: "work",
      categoryNum: 2,
      description:
          "this is the descroption of the not sha this is the descroption of the not sha",
      date: DateTime.now(),
    ),
    NoteModel(
      id: 7,
      category: "work",
      categoryNum: 2,
      description:
          "this is the descroption of the not sha this is the descroption of the not sha",
      date: DateTime.now(),
    ),
    NoteModel(
      id: 8,
      category: "work",
      categoryNum: 2,
      description:
          "this is the descroption of the not sha this is the descroption of the not sha",
      date: DateTime.now(),
    ),
    NoteModel(
      id: 9,
      category: "uncategorizeds",
      categoryNum: 1,
      description:
          "this is the descroption of the not sha this is the descroption of the not sha",
      date: DateTime.now(),
    ),
    NoteModel(
      id: 10,
      category: "family affairs",
      categoryNum: 3,
      description:
          "this is the descroption of the not sha this is the descroption of the not sha",
      date: DateTime.now(),
    ),
    NoteModel(
      id: 11,
      category: "Study",
      categoryNum: 4,
      description:
          "this is the descroption of the not sha this is the descroption of the not sha",
      date: DateTime.now(),
    ),
    NoteModel(
      id: 12,
      category: "Personal",
      categoryNum: 5,
      description: "this is the descroption of the not sha",
      date: DateTime.now(),
    ),
    NoteModel(
      id: 13,
      category: "work",
      categoryNum: 2,
      description: "this is the descroption of the not sha",
      date: DateTime.now(),
    ),
    NoteModel(
      id: 14,
      category: "work",
      categoryNum: 2,
      description: "this is the descroption of the not sha",
      date: DateTime.now(),
    ),
  ];

  void sortByDate() {
    noteModels.sort((a, b) => b.date.toString().compareTo(a.date.toString()));
    notifyListeners();
  }

  void sortByCategories() {
    noteModels.sort((a, b) => a.categoryNum - b.categoryNum);
    notifyListeners();
  }

  void addNoteToDb(NoteModel noteModel) async {
    print("this method");
    print(noteModels);
    await DBProvider.db.createNewNote(noteModel);
    noteModels.insert(0, noteModel);
    print(noteModels.length);
    notifyListeners();
    getAllDataFromDb();
  }

  void updateNoteToDb(NoteModel noteModel) async {
    noteModel.dateTime = noteModel.date.toString();
    int index = noteModels.indexWhere((element) => element.id == noteModel.id);
    if (index != -1) {
      noteModels[index].category = noteModel.category;
      noteModels[index].categoryNum = noteModel.categoryNum;
      noteModels[index].description = noteModel.description;
      noteModels[index].date = noteModel.date;
      noteModels[index].dateTime = DateTime.now().toString();
      notifyListeners();
    }
    noteModel.dateTime = DateTime.now().toString();
    await DBProvider.db.updateNote(noteModel);
  }

  // void getNoteFromDb(int id) async {
  //   note = await DBProvider.db.getNote(id);
  //   notifyListeners();
  // }

  void getAllDataFromDb() async {
    final notes = await DBProvider.db.getAllNotes();
    noteModels.clear();
    for (var id = 0; id < notes.length; id++) {
      noteModels.add(notes[id]);
    }
    notifyListeners();
  }

  void deleteNote(List<int> markedInt) async {
    for (var id = 0; id < markedInt.length; id++) {
      await DBProvider.db.deleteNotes(markedInt[id]);
      noteModels.removeWhere((element) => element.id == marked[id]);
      marking = false;
    }

    notifyListeners();
  }

  void deleteAllNotes() async {
    await DBProvider.db.deleteAll();
    noteModels.clear();
    notifyListeners();
  }
}
