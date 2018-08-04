import 'package:flutter/material.dart';

void main() => runApp(new MaterialApp(
  theme: new ThemeData(
    primarySwatch: Colors.blue,
  ),
  home: new MyShoppingList(),
));

class MyShoppingList extends StatefulWidget {
  @override
  createState() => MyShoppingListState();
}


class MyShoppingListState extends State<MyShoppingList> with SingleTickerProviderStateMixin {
  final items = List<String>.generate(15, (i) => "Item ${i + 1}");
/* AnimationController _controller;

  @override
  void initState() {
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }
  */

  @override
  Widget build(BuildContext context) {
    return MaterialApp (
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(

       /*     floatingActionButton: new FloatingActionButton(
              heroTag: null,
              child: new AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, Widget child) {
                  return new Transform(
                    transform: new Matrix4.rotationZ(_controller.value * 0 * 3.14),
                    alignment: FractionalOffset.center,
                    child: new Icon(_controller.isDismissed ? Icons.add : Icons.arrow_forward),
                  );
                },
              ),
              onPressed: () {
                if (_controller.isDismissed) {
                  _controller.forward();
                } else {
                  _controller.reverse();
                }
              },
            ),

         */

            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.shopping_cart)),
                Tab(icon: Icon(Icons.done)),
              ],
            ),
            title: Text('Shopping List App'),

          ),
          body: TabBarView(
            children: [
              _buildSuggestions(),
              Icon(Icons.directions_transit),
            ],
          ),
        ),
      ),



    );


  }

  Widget _buildSuggestions() {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return Dismissible(
          key: Key(item),
          onDismissed: (direction) {
            setState(() {
              items.removeAt(index);
            });

            // Then show a snackbar!
            Scaffold
                .of(context)
                .showSnackBar(SnackBar(content: Text("$item dismissed")));
          },
          // Show a red background as the item is swiped away
          background: Container(color: Colors.red),
          child: ListTile(title: Text('$item')),
        );
      },
    );
  }


}