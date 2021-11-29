import 'package:baitap9/contact_detail.dart';
import 'package:baitap9/contact_object.dart';
import 'package:baitap9/contact_provider.dart';
import 'package:flutter/material.dart';

class ContactSearch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ContactSearchState();
  }
}

class ContactSearchState extends State<ContactSearch> {
  List<ContactObject> lsContact = [];
  TextEditingController txtSearch = TextEditingController();
  void _searchContact() async {
    if (txtSearch.text.isNotEmpty) {
      final data = await ContactProvider.searchContacts((txtSearch.text));
      setState(() {});
      lsContact = data;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: TextField(
            autofocus: true,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              border: InputBorder.none,
            ),
            onChanged: (text) {
              _searchContact();
            },
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(5),
        child: ListView.builder(
          itemCount: lsContact.length,
          itemBuilder: (context, index) => Card(
              child: ListTile(
            title: Text(lsContact[index].name),
            subtitle: Text(
              lsContact[index].phone,
            ),
            leading: CircleAvatar(
              child: Text(
                lsContact[index].name.substring(0, 1).toLowerCase(),
              ),
            ),
            onTap: () {
              int? id = lsContact[index].id;
              if (id != null) {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ContactDetail(id: id)))
                    .then((value) => null);
              }
            },
          )),
        ),
      ),
    );
  }
}
