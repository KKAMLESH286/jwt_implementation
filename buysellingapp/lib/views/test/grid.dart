import 'package:flutter/material.dart';

class GirdScreen extends StatefulWidget {
  @override
  _GirdScreenState createState() => _GirdScreenState();
}

class _GirdScreenState extends State<GirdScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: GridView.builder(
        itemCount: 4,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 8.0, mainAxisSpacing: 8.0),
        itemBuilder: (_, index) {
          return Container(
            height: 150,
            width: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "title",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(hintText: "Enter Date"),
                  ),
                ),
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(hintText: "Enter Topic"),
                  ),
                )
              ],
            ),
          );
        },
      ),
    ));
  }
}
