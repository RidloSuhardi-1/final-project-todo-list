import 'package:flutter/material.dart';
import 'package:uas_final/themes.dart';

class TodoCard extends StatelessWidget {
  const TodoCard(
      {this.id = 0,
      this.title = 'no name',
      this.subTitle = 'no text',
      this.moveToPage});

  final String title, subTitle;
  final int id;
  final moveToPage;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        onTap: () {},
        title: Text(title,
            style: poppinsBold.copyWith(fontSize: 18, color: black)),
        subtitle: Text(
          subTitle,
          style: poppinsLight.copyWith(fontSize: 14, color: grey),
        ),
        trailing: TextButton(
          onPressed: () {},
          child: Image.asset(
            'assets/images/edit.png',
            width: 20,
            height: 20,
          ),
          style: TextButton.styleFrom(
            primary: green,
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
