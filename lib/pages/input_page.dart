import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uas_final/services/database.dart';
import 'package:flutter/material.dart';
import 'package:uas_final/themes.dart';

class InputPage extends StatefulWidget {
  const InputPage(
      {this.title = '',
      this.desc = '',
      this.label = 'Direncanakan',
      this.id,
      this.labelId});

  final String title, desc, label, id, labelId;

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final CollectionReference noteCollections = firestore.collection('notes');
  final CollectionReference labelCollections = firestore.collection('label');

  TextEditingController namaTugas, keterangan, label;

  @override
  void initState() {
    namaTugas = TextEditingController(
        text: (widget.title.isNotEmpty) ? widget.title : '');
    keterangan = TextEditingController(
        text: (widget.desc.isNotEmpty) ? widget.desc : '');
    label = TextEditingController(text: widget.label);
    super.initState();
  }

  @override
  void dispose() {
    namaTugas.dispose();
    keterangan.dispose();
    super.dispose();
  }

  void onChangeItem(String value) {
    label.text = value;
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference notes = firestore.collection('notes');

    // Header
    var header = Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Back'),
          ),
          SizedBox(
            width: 50,
          ),
          Container(
            width: 200,
            child: Text(
              (widget.title == '') ? 'CATATAN BARU' : widget.title,
              overflow: TextOverflow.ellipsis,
              style: poppinsBold.copyWith(
                fontSize: 16,
                color: black,
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.grey, blurRadius: 5.0),
      ]),
    );

    // Input field
    var inputField = Container(
      child: Column(
        children: [
          textField(namaTugas, message: 'Nama Tugas...'),
          SizedBox(
            height: 15,
          ),
          Container(
            width: double.infinity,
            child: StreamBuilder<QuerySnapshot>(
              stream: Database.readLabels(),
              builder: (_, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
                if (snapshot.hasData) {
                  return DropdownButton(
                    onTap: () {},
                    items: snapshot.data.docs
                        .map((e) => DropdownMenuItem(
                            value: e['name'], child: Text(e['name'])))
                        .toList(),
                    hint: Text(label.text),
                    onChanged: (value) {
                      setState(() => label.text = value);
                    },
                  );
                } else {
                  return DropdownButton(
                    onTap: () {},
                    items: <String>['Direncanakan'].map((_) {
                      return DropdownMenuItem(
                          value: 'Direncanakan', child: Text('Direncanakan'));
                    }).toList(),
                    hint: Text(label.text),
                    onChanged: (value) {
                      setState(() => label.text = value);
                    },
                  );
                }
              },
            ),
          ),
          textField(keterangan, message: 'Keterangan...'),
          SizedBox(
            height: 30,
          ),
          Container(
            width: double.infinity,

            // Simpan data
            child: ElevatedButton(
              onPressed: () async {
                if ((widget.title == '') && (widget.desc == '')) {
                  await Database.addNote(
                      title: namaTugas.text, desc: keterangan.text);
                } else {
                  await noteCollections.doc(widget.id).update({
                    'title': namaTugas.text,
                    'description': keterangan.text,
                  });
                }

                namaTugas.text = '';
                keterangan.text = '';

                Navigator.of(context).pop();
              },
              child: Text(
                (widget.title == '') ? 'Buat...' : 'Perbarui...',
                style: poppinsBlack.copyWith(
                  fontSize: 16,
                  color: Color(0xffffffff),
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.lightBlue,
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          )
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(.5), blurRadius: 2.5),
        ],
      ),
    );

    // Label field
    var labelField = Container(
      child: Column(
        children: [
          textField(label, message: 'Label baru...'),
          SizedBox(
            height: 30,
          ),
          Container(
            width: double.infinity,

            // Simpan data
            child: ElevatedButton(
              onPressed: () async {
                if (widget.labelId != null) {
                  await labelCollections.doc(widget.labelId).update({
                    'name': label,
                  });
                } else {
                  await Database.addLabel(name: label.text);
                }
              },
              child: Text(
                'Buat label...',
                style: poppinsBlack.copyWith(
                  fontSize: 16,
                  color: Color(0xffffffff),
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: green,
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          )
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(.5), blurRadius: 2.5),
        ],
      ),
    );

    // MAIN

    return Scaffold(
      backgroundColor: Color(0XFFF0FFFF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              header,
              SizedBox(
                height: 20,
              ),
              inputField,
              SizedBox(
                height: 20,
              ),
              labelField,
            ],
          ),
        ),
      ),
    );
  }

  textField(TextEditingController controller,
      {String message = 'Type here..'}) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      maxLines: 1,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2)),
        hintText: message,
        hintStyle: poppinsRegular.copyWith(fontSize: 16),
      ),
      onChanged: (value) {},
    );
  }
}
