import 'package:flutter/material.dart';
import 'package:netflix_clone/core/responses/Item.dart';

class DetailPage extends StatelessWidget {
  final Item _item;

  DetailPage(this._item);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.network(_item.imageUrl),
            Text(
              _item.title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
