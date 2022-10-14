import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // trending
  // https://api.giphy.com/v1/gifs/trending?api_key=ig4Tq7SFdZRrHpOlwqYfjxdEwx2tmPhO&limit=25&rating=g

  // search
  // https://api.giphy.com/v1/gifs/search?api_key=ig4Tq7SFdZRrHpOlwqYfjxdEwx2tmPhO&q=&limit=25&offset=0&rating=g&lang=en

  String _search = "";
  int _offset = 25;

  _getGifs() async {
    http.Response response;
    if (_search == "") {
      response = await http.get(Uri.parse("https://api.giphy.com/v1/gifs/trending?api_key=ig4Tq7SFdZRrHpOlwqYfjxdEwx2tmPhO&limit=25&rating=g"));
    } else {
      response = await http.get(Uri.parse("https://api.giphy.com/v1/gifs/search?api_key=ig4Tq7SFdZRrHpOlwqYfjxdEwx2tmPhO&q=$_search&limit=25&offset=$_offset&rating=g&lang=en"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title:
          Image.network(
            "https://developers.giphy.com/branch/master/static/header-logo-0fec0225d189bc0eae27dac3e3770582.gif",
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.black54,
        body: Column(
          children: <Widget>[
            const Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Pesquise aqui",
                    labelStyle: TextStyle(color: Colors.white, fontSize: 20.0),
                    border: OutlineInputBorder(),
                  ),
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
            ),
            Expanded(child: FutureBuilder(
              future: _getGifs(),
              builder: (context, snapshot){
                switch(snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Container(
                        width: 200.0,
                        height: 200.0,
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white),
                            strokeWidth: 5.0)
                    );
                  default:
                    return (snapshot.hasError) ? Container() : _createGifTable(context, snapshot);
                }
              },
            ))
          ],
        )
    );
  }

  Widget _createGifTable(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing : 10.0,
            mainAxisSpacing: 10.0
        ),
        itemCount: 4,
        itemBuilder : (context, index){
          return GestureDetector(
            child : Image.network(
              snapshot.data["data"][index]["images"]["fixed_height"]["url"],
              height: 300.0,
              fit: BoxFit.cover,
            ),
          );
        }
    );
  }
}

