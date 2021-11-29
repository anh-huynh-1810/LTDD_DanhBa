import 'package:baitap9/contact_detail.dart';
import 'package:baitap9/contact_object.dart';
import 'package:baitap9/contact_provider.dart';
import 'package:flutter/material.dart';

class ContactsTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ContactsTabState();
  }
}

class ContactsTabState extends State<ContactsTab> {
  List<ContactObject> lsContacts = [];

  void _LoadDanhSachContact() async {
    final data = await ContactProvider.getAllContacts();
    setState(() {});
    lsContacts = data;
  }

  @override
  void initState() {
    super.initState();
    _LoadDanhSachContact();
  }

  Widget _MenuItem(int index) {
    int? id = lsContacts[index].id;
    return PopupMenuButton(
      icon: Icon(Icons.more_vert),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.edit),
            title: Text('Cập Nhật Thông Tin Liên Hệ'),
            subtitle:
                Text('Cập Nhật Thông Tin Liên Hệ ' + lsContacts[index].name),
            onTap: () {
              Navigator.pop(context);
              if (id != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContactDetail(
                      id: id,
                    ),
                  ),
                ).then((value) => {_LoadDanhSachContact()});
              }
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.delete),
            title: Text('Xoá Liên Hệ'),
            subtitle: Text('Xoá Liên Hệ ' + lsContacts[index].name),
            onTap: () {
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Xoá danh bạ'),
                      content: Text('Vui lòng xác nhận xoá' +
                          lsContacts[index].name +
                          'Khỏi danh bạ?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            if (id != null) {
                              ContactProvider.deleteContact(id);
                              _LoadDanhSachContact();
                            }
                          },
                          child: Text('Xoá'),
                        )
                      ],
                    );
                  });
            },
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(5),
        child: ListView.builder(
            itemCount: lsContacts.length,
            itemBuilder: (context, index) => Card(
                  child: ListTile(
                    title: Text(lsContacts[index].name),
                    subtitle: Text(lsContacts[index].phone),
                    leading: CircleAvatar(
                      child: Text(
                          lsContacts[index].name.substring(0, 1).toUpperCase()),
                    ),
                    trailing: _MenuItem(index),
                  ),
                )),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ContactDetail(
                id: 0,
              ),
            ),
          ).then((value) => {_LoadDanhSachContact()});
        },
      ),
    );
  }
}
