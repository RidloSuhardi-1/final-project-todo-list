import 'package:flutter/material.dart';
import 'package:uas_final/pages/home_page.dart';
import 'package:uas_final/themes.dart';
import 'package:uas_final/widgets/card_todo.dart';
import 'package:uas_final/services/signin.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
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
          Container(
            width: 50,
            height: 50,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                (imageUrl != null)
                    ? imageUrl
                    : 'https://d1nhio0ox7pgb.cloudfront.net/_img/o_collection_png/green_dark_grey/256x256/plain/user.png',
              ),
            ),
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
                (name != null) ? name : 'no name',
                style: poppinsBold.copyWith(fontSize: 22, color: green),
              ),
            ],
          ),
          Spacer(),
          IconButton(
              onPressed: () {
                // logout akun
                signOutGoogle();

                // kembali ke halaman login
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {
                  return HomePage();
                }), ModalRoute.withName('/'));
              },
              icon: Icon(
                Icons.logout,
                color: Colors.red,
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
