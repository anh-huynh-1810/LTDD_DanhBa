import 'package:baitap9/contact_object.dart';
import 'package:baitap9/contact_provider.dart';
import 'package:flutter/material.dart';

class ContactDetail extends StatefulWidget {
  final int id;

  const ContactDetail({Key? key, required this.id}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return ContactDetailState(id: id);
  }
}

class ContactDetailState extends State<ContactDetail> {
  final int id;
  ContactDetailState({required this.id});
  TextEditingController txtName = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  List<ContactObject> lsContact = [];
  void _BindingContact() async {
    setState(() {});
    final data = await ContactProvider.getContacts(id);
    lsContact = data;
    if (lsContact.length > 0) {
      txtName.text = lsContact.first.name;
      txtPhone.text = lsContact.first.phone;
    }
  }

  @override
  void initState() {
    super.initState();
    _BindingContact();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(id == 0 ? 'Thêm Mới Danh Bạ' : 'Thông Tin Chi Tiết'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                  controller: txtName,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    hintText: 'Nhập Tên Liên Hệ',
                    labelText: 'Tên Liên hệ',
                  )),
            ),
            Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  controller: txtPhone,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      hintText: 'Nhập Số Điện Thoại',
                      labelText: 'Số Điện Thoại'),
                )),
            Padding(
              padding: const EdgeInsets.all(15),
              child: OutlinedButton(
                onPressed: () async {
                  ContactObject con = ContactObject(
                      id: id, name: txtName.text, phone: txtPhone.text);
                  if (id == 0) {
                    await ContactProvider.insertContact(con);
                  } else {
                    await ContactProvider.updateContact(con);
                  }
                  Navigator.pop(context);
                },
                child: const Text(
                  'Lưu Danh Bạ',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
