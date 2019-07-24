import 'package:flutter/material.dart';

class SlidesLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        semanticContainer: true,
        child: Container(
          height: 200,
          width: 400,
          decoration: BoxDecoration(),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(bottom: 10, top: 10),
                    child: buildContainer()),
                buildContainer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildContainer() {
    return Container(
      color: Colors.grey[200],
    );
  }
}
