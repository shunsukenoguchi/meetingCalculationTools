import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final items = List<String>.generate(10000, (i) => "Item $i");
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          leading: Icon(Icons.videocam),
          title: const Text('youtubeアプリ'),
          actions: <Widget>[
            SizedBox(
              width: 40,
              child: FlatButton(
                child: Icon(Icons.search),
                onPressed: () {
                  //処理コード
                },
              ),
            ),
            SizedBox(
              width: 40,
              child: FlatButton(
                child: Icon(Icons.more_vert),
                onPressed: () {
                  //処理コード
                },
              ),
            )
          ],
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.network(
                      'https://yt3.ggpht.com/kdR-xpTPlb61vw9XIMQnn_ZQK1ZL52fJ6ijSQAPacG9PJGRF9g7XDKHbbzmiO8sBx0zYKLXP=s48-c-k-c0x00ffffff-no-rj',
                    ),
                  ),
                  Column(
                    children: <Widget>[const Text('youtube大学')],
                  ),
                  FlatButton(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.video_call,
                          color: Colors.red,
                        ),
                        Text('登録する')
                      ],
                    ),
                    onPressed: () {
                      // todo
                    },
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: EdgeInsets.all(8),
                      leading: Image.network(
                        'https://yt3.ggpht.com/kdR-xpTPlb61vw9XIMQnn_ZQK1ZL52fJ6ijSQAPacG9PJGRF9g7XDKHbbzmiO8sBx0zYKLXP=s48-c-k-c0x00ffffff-no-rj',
                      ),
                      title: Column(children: <Widget>[
                        Text('kboyのflutter大学'),
                        Row(
                          children: <Widget>[
                            Text('264万回再生'),
                            Text('5日間'),
                          ],
                        )
                      ]),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
