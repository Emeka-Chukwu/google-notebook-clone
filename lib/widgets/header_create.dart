import 'package:flutter/material.dart';
import 'package:notebook/utils/responsive.dart';

class CreateHeader extends StatelessWidget {
  final Function cancel;
  final Function save;

  const CreateHeader({Key key, this.cancel, this.save}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: Responsive.screenWidth(4, context)),
      color: Colors.yellow[900],
      height: Responsive.screenHeight(12, context),
      child: Padding(
        padding: EdgeInsets.only(top: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              child: Text(
                "Cancel",
                style: TextStyle(
                  fontSize: Responsive.textSize(4.5, context),
                  color: Colors.white,
                ),
              ),
              onTap: cancel,
            ),
            GestureDetector(
              child: Text(
                "Save",
                style: TextStyle(
                  fontSize: Responsive.textSize(4.5, context),
                  color: Colors.white,
                ),
              ),
              onTap: save,
            ),
          ],
        ),
      ),
    );
  }
}
