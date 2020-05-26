import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main(){
  runApp(MaterialApp(
    title: "Todo App with Re-orderable Lists & Swipe Cards",
    home: App(),
  ));
}

List<String> items = ["Item 1 - I will stick to the new position!",
                  "Item 2 - I will stick to the new position!",
                  "Item 3 - I will stick to the new position!"];

bool toggle = false;

class _strikeThrough extends StatelessWidget{

  bool todoToggle;
  String todoText;
  _strikeThrough({this.todoToggle, this.todoText}) : super();

  Widget _strikewidget(){
    if(todoToggle==false){
      return Text(
          todoText,
          style: TextStyle(
            fontSize: 22.0
          ),
      );
    }
    else{
      return Text(
          todoText,
          style: TextStyle(
            fontSize: 22.0,
            decoration: TextDecoration.lineThrough,
            color: Colors.redAccent,
            fontStyle: FontStyle.italic
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _strikewidget();
  }
}

class App extends StatefulWidget{
  @override
  AppState createState() {
    return AppState();
  }
}

class AppState extends State<App>{ 

Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("First Empty Half Baked App"),
      ),
      body: ReorderableListView(
        children: <Widget>[
          for(var item in items)
            CheckboxListTile(
              value: toggle,
              onChanged: (bool){
                setState(() {
                  if(!bool){
                    toggle = false;
                  }
                  else{
                    toggle = true;
                  }
                });
              },
              key: Key(item),
              title: _strikeThrough(todoText: item, todoToggle: toggle),
              )          
        ],
        onReorder: (OldIndex, NewIndex){
          setState(() {
            if(OldIndex < NewIndex){
              NewIndex -= 1;
            }
            var getReplacedWidget = items.removeAt(OldIndex);
            items.insert(NewIndex, getReplacedWidget);
          });
        },
      ),
    );
  }
}

