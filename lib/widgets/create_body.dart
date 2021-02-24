// import 'package:flutter/material.dart';
// import 'package:notebook/utils/responsive.dart';

// class CreateBody extends StatelessWidget {
//   TextEditingController controller = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Container(
//         height: Responsive.screenHeight(88, context),
//         padding: EdgeInsets.symmetric(
//             horizontal: Responsive.screenWidth(2, context)),
//         child: Column(
//           children: [
//             Expanded(
//                 child: TextField(
//               maxLines: 30,
//             )),
//             Container(
//               child: Row(
//                 children: [Container()],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notebook/utils/responsive.dart';
import 'package:notebook/view_model/note.dart';

class RowCategory extends StatelessWidget {
  final Function onTap;
  final int index;
  final ChangeNotifierProvider<Note> note;

  const RowCategory({Key key, this.onTap, this.index, this.note})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final add = watch(note);
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                print("hhere");
                onTap(1);
                add.showToast(context, "Uncategorized");
              },
              child: Icon(
                Icons.grid_view,
                color: index == 1 ? Colors.purple : Colors.black,
                size: Responsive.textSize(6, context),
              ),
            ),
            GestureDetector(
              onTap: () {
                onTap(2);
                add.showToast(context, "Work");
              },
              child: index == 2
                  ? Icon(
                      Icons.work,
                      size: Responsive.textSize(6, context),
                      color: Colors.orange,
                    )
                  : Icon(
                      Icons.work_outline,
                      size: Responsive.textSize(6, context),
                    ),
            ),
            GestureDetector(
              onTap: () {
                onTap(3);
                add.showToast(context, "Family affairs");
              },
              child: index == 3
                  ? Icon(
                      Icons.home,
                      size: Responsive.textSize(6, context),
                      color: Colors.blue,
                    )
                  : Icon(
                      Icons.home_outlined,
                      size: Responsive.textSize(6, context),
                      color: index == 3 ? Colors.blue : Colors.black,
                    ),
            ),
            GestureDetector(
              onTap: () {
                onTap(4);
                add.showToast(context, "Study");
              },
              child: index == 4
                  ? Icon(
                      Icons.book,
                      size: Responsive.textSize(6, context),
                      color: Colors.yellow[900],
                    )
                  : Icon(
                      Icons.book_outlined,
                      size: Responsive.textSize(6, context),
                    ),
            ),
            GestureDetector(
              onTap: () {
                onTap(5);
                add.showToast(context, "Personal");
              },
              child: index == 5
                  ? Icon(
                      Icons.person,
                      size: Responsive.textSize(6, context),
                      color: Colors.green,
                    )
                  : Icon(
                      Icons.person_outline_outlined,
                      size: Responsive.textSize(6, context),
                    ),
            ),
          ],
        ),
      );
    });
  }
}
