import 'package:baitap9/contact_detail.dart';
import 'package:baitap9/contact_search.dart';
import 'package:flutter/material.dart';
import 'contacts_tab.dart';

void main() {
  runApp(MaterialApp(
    title: 'Danh Bạ',
    theme: ThemeData.dark(),
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: "Tìm bạn bè, tìm tin nhắn...",
                    border: InputBorder.none,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ContactSearch()));
                  },
                ),
              ),
              IconButton(
                  onPressed: null, icon: Icon(Icons.add_photo_alternate)),
              IconButton(
                  onPressed: null, icon: Icon(Icons.notifications_outlined)),
            ],
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.access_time_filled_outlined),
              ),
              Tab(
                icon: Icon(Icons.account_box_outlined),
              ),
              Tab(
                icon: Icon(Icons.messenger_outlined),
              ),
            ],
          ),
        ),
        body: Center(
          child: TabBarView(
            children: [
              Text('Nhật ký'),
              ContactsTab(),
              Text('Tin Nhắn'),
            ],
          ),
        ),
      ),
    );
  }
}
