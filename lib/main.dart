import 'package:flutter/material.dart';
import 'package:film_browser/repository.dart';
import 'package:film_browser/api.dart';
import 'package:injector/injector.dart';


// todo
// use repository in widgets
// customize api for omdb platform and test it
// create widgets classes for list and text field and mock its work
// add bloc pattern
// create detail screen
// favs list < saved in sqlite db , available from main screen>, also create possibility to add movie to favs from details


void main() => runApp(FilmBrowser());

class FilmBrowser extends StatelessWidget {
  final Injector injector = Injector();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: MyHomePage(title: 'MovieBrowser'),
    );
  }

  FilmBrowser(){
    injector.registerSingleton<Api>((_) => TestApi());

    injector.registerSingleton<Repository>((_injector) {
      return Repository(api: _injector.getDependency<Api>());
    });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  String title = "";

  void getData(){

  }

  @override
  void initState(){
      getData();
  }

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.pink,
      ),
      body:
         Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                child : Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.pink)),
                        hintText: 'find movie..',
                        labelText: 'find movie',
                    ),
                  ),
                ),
            ),
            Container(
              child: Expanded(
                child: ListView(
                  children: list,
                ),
              ),
            ),
          ],
        ),
    );
  }
}

List<Widget> list = <Widget>[
  ListTile(
    title: Text('Kac Vegas 1',
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
    subtitle: Text('Kac Vegas 1'),
    leading: Icon(
      Icons.theaters,
      color: Colors.pink,
    ),
  ),
  ListTile(
    title: Text('Kac Vegas 2',
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
    subtitle: Text('Kac Vegas 2'),
    leading: Icon(
      Icons.theaters,
      color: Colors.pink,
    ),
  ),
];

