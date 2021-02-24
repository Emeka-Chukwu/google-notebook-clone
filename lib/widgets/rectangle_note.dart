import 'package:flutter/material.dart';
import 'package:notebook/utils/color.dart';
import 'package:notebook/utils/responsive.dart';

class NoteBlock extends StatelessWidget {
  final int index;

  const NoteBlock({Key key, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.screenWidth(2, context),
      height: Responsive.screenHeight(10, context),
      child: Stack(
        children: [
          Container(
            height: Responsive.screenHeight(10, context),
            width: Responsive.screenWidth(2, context),
            color: categoryColor(index),
          ),
          Container(
            alignment: Alignment.center,
            child: Container(
              height: Responsive.screenHeight(2, context),
              width: Responsive.screenWidth(1, context),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
