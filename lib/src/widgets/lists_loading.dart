import 'package:flutter/material.dart';

class ListLoading extends StatelessWidget {
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        child: SizedBox(
          height: 110,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              builContainer(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 5.0, 2.0, 5.0),
                  child: postDesc(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget postDesc() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              builContainer(),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              builContainer(),
              builContainer(),
              builContainer(),
            ],
          ),
        )
      ],
    );
  }

  Widget builContainer() {
    return Container(
      color: Colors.grey,
    );
  }
}
