import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MaterialApp(
  theme: new ThemeData(
    primarySwatch: Colors.blue,
  ),
  home: new RandomWords(),

));


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}


class RandomWords extends StatefulWidget {
  @override
  createState() => RandomWordsState();
}


//111111111111111111111111111111111111111111111111111111111111111111111111111111
class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{
TabController tabController;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = new TabController(length: 2, vsync: this);
  }
  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Shopping List"),
        bottom: new TabBar(
            controller: tabController,
            tabs: <Widget>[
              new Tab(
                icon: new Icon(Icons.shopping_basket),
              ),
              new Tab(
                icon: new Icon(Icons.done),
              )
            ],
          ),

        ),


      body: new TabBarView(
        children: <Widget>[
          new NewPage("First"), new NewPage("Second")
        ],
        controller: tabController,
      ),

      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: ()=> TextField(decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Please enter a search term'
        ),),
      ),
    );

  }
}

class NewPage extends StatelessWidget {
  final String title;
  NewPage(this.title);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        child: new Text(title),
      ),
    );
  }
}

//222222222222222222222222222222222222222222222222222222222222222222222222222222Scaffold

class RandomWordsState extends State<RandomWords> {

  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);
  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          final tiles = _saved.map(
                (pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile
              .divideTiles(
            context: context,
            tiles: tiles,
          )
              .toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();
          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        }
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),

      trailing: Icon(
        alreadySaved ? Icons.check_box : Icons.check_box_outline_blank,
        color : alreadySaved ? Colors.green : null,
      ),

      onTap: (){
        setState(() {
          if(alreadySaved){
            _saved
                .remove(pair);
          }else{
            _saved.add(pair);
          }
        });
      },
    );
  }
}