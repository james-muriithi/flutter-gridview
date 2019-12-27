import 'package:flutter/material.dart';
import 'package:grid_view/album.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Gridview',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Flutter Gridview Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future data;
  Future<List<Album>> _getAlbum() async {
    var data = await http.get("https://jsonplaceholder.typicode.com/photos");
    var jsonData = json.decode(data.body);

    List<Album> albums = [];

    for (var u in jsonData) {
      Album album =
          Album(u["albumId"], u["id"], u["title"], u["url"], u["thumbnailUrl"]);
      albums.add(album);
    }

    return albums;
  }

  @override
  void initState() {
    data = _getAlbum();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
          child: FutureBuilder(
        future: data,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: Text('loading....'),
              ),
            );
          }

          return GridView.builder(
            itemCount: snapshot.data.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Hero(
                    tag: snapshot.data[index].id,
                    child: Material(
                      child: InkWell(
                        onTap: () {},
                        splashColor: Colors.brown.withOpacity(0.5),
                        child: GridTile(
                          child: FadeInImage.assetNetwork(
                              fit: BoxFit.cover, image: snapshot.data[index].thumbNailUrl,
                               placeholder: snapshot.data[index].thumbNailUrl,
                               width: 100,
                               height: 100,
                              ),
                          footer: Container(
                            color: Colors.black12,
                            child: ListTile(
                              leading: Text(
                                'Image ' + snapshot.data[index].id.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              trailing: new IconButton(
                                icon: Icon(Icons.favorite,color: Colors.white70), 
                                highlightColor: Colors.pink,
                              onPressed: () {
                                
                              },
                              )
                            ),
                          ),
                        ),
                      ),
                    )),
              );
            },
          );
        },
      )),
    );
  }
}

class Album {
  int albumId, id;
  String title, url, thumbNailUrl;
  Album(this.albumId, this.id, this.title, this.url, this.thumbNailUrl);
}
