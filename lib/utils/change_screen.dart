import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notebook/view_model/note.dart';

void changeScreen(BuildContext context, Widget widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

changeScreenWithResponse(BuildContext context, Widget widget, Note note) async {
  final state = await Navigator.push(
      context, MaterialPageRoute(builder: (context) => widget));

  if (state != null) note.showToast(context, state, Alignment.bottomCenter);
}
