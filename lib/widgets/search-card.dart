import 'package:flutter/material.dart';

Widget searchCard(
  Function onValueSaved,
  TextEditingController controller,
  double width,
  Function onSearchPressed,
) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50.0),
    ),
    margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
      ),
      padding: EdgeInsets.only(left: 15.0, bottom: 0.0, top: 5.0),
      child: Row(
        children: <Widget>[
          Container(
            width: width * .6,
            child: textField(onValueSaved, 'Search...', controller),
          ),
          Container(
            child: IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                onPressed: onSearchPressed),
          )
        ],
      ),
    ),
  );
}

Widget textField(
    onValueSaved, String hintText, TextEditingController controller) {
  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.text,
    onSaved: onValueSaved,
    decoration: InputDecoration(
      hintText: hintText,
      border: InputBorder.none,
    ),
  );
}

Widget icons(onCancelPressed) {
  return Row(
    children: <Widget>[
      Expanded(
        child: iconButton(Icons.highlight_off, "Skip",
            Color.fromRGBO(246, 41, 111, 1), () {}),
      ),
      Expanded(
          child: iconButton(Icons.check_circle_outline, "Taking",
              Color.fromRGBO(0, 230, 118, 1), () {})),
      Expanded(
        child: GestureDetector(
            onTap: () {},
            child: Column(
              children: <Widget>[
                Container(
                  child: Container(
                    height: 34,
                    width: 34,
                    margin: EdgeInsets.only(bottom: 3),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.deepOrange, width: 2.8),
                        borderRadius: BorderRadius.circular(100)),
                    child: Center(
                        child: Container(
                            child: Icon(
                      Icons.access_alarms,
                      size: 24.0,
                      color: Colors.deepOrange,
                    ))),
                  ),
                ),
                Text(
                  "Postpone",
                  style: TextStyle(color: Colors.deepOrange, fontSize: 13),
                )
              ],
            )),
      ),
    ],
  );
}

Widget iconButton(icon, text, color, onPressed) {
  return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: <Widget>[
          Container(
            child: Icon(
              icon,
              size: 38,
              color: color,
            ),
          ),
          Text(
            text,
            style: TextStyle(color: color, fontSize: 13),
          )
        ],
      ));
}
