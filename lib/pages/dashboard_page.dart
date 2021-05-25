import 'package:flutter/material.dart';
import 'package:uas_final/themes.dart';
import 'package:uas_final/widgets/card_todo.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({this.name = 'no name'});

  final String name;

  @override
  _DashboardPageState createState() => _DashboardPageState(name: name);
}

class _DashboardPageState extends State<DashboardPage> {
  _DashboardPageState({this.name});

  String name;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Header aplikasi yang berisi nama pengguna saat login
    var header = Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.menu_rounded,
            color: black,
            size: 25,
          ),
          SizedBox(
            width: 22,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Halo',
                style: poppinsBold.copyWith(fontSize: 22, color: black),
              ),
              Text(
                name,
                style: poppinsBold.copyWith(fontSize: 22, color: green),
              ),
            ],
          ),
          Spacer(),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.post_add_outlined,
                color: black,
                size: 25,
              )),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: grey.withOpacity(0.5),
            blurRadius: 0.5,
            offset: Offset.fromDirection(1.0),
          ),
        ],
      ),
    );

    // Daftar kartus

    var listOfCard = Expanded(
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            TodoCard(
                id: 1, title: "Bahasa Indonesia", subTitle: "PR Halaman 21"),
            TodoCard(id: 2, title: "Penjaskes", subTitle: "Scout Jump"),
            TodoCard(
                id: 3, title: "Main Bola", subTitle: "Jam 10 main di lapa.."),
          ],
        ),
      ),
    );

    // Main section

    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          header,
          listOfCard,
        ],
      )),

      // Floating Button

      floatingActionButton: Container(
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.post_add_outlined),
            backgroundColor: green,
            tooltip: 'Tambah catatan baru',
          ),
        ),
        width: 65,
        height: 65,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
