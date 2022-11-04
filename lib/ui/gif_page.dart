import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';

class GifPage extends StatelessWidget {
  final Map _gifData;
  GifPage(this._gifData);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_gifData["title"]),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              share();
            },
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(_gifData["images"]["fixed_height"]["url"]),
      ),
    );
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: 'GIF', linkUrl: (_gifData["images"]["fixed_height"]["url"]));
  }
}
