import 'package:flutter/material.dart';
import 'dart:async';
import './main.dart';

class Task extends StatefulWidget {
  const Task({int i, Key key})
      : i = i,
        super(key: key);
  final int i;

  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  void _toggleChecked() {
    setState(() {
      if (taskPressed[widget.i]) {
        taskPressed[widget.i] = false;
      } else {
        taskPressed[widget.i] = true;
      }
    });
  }

  Future<Null> _changeTaskName() {
    return showDialog<Null>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            content: TextField(
              autofocus: true,
              decoration: new InputDecoration(labelText: 'Task Name'),
              onChanged: (value) {
                setState(() {
                  taskName[widget.i] = value;
                });
              },
            ),
          );
        });
  }

  Future<Null> _displaySizeChangeDialog() {
    return showDialog<Null>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey[300],
            actions: <Widget>[
              Container(
                padding: EdgeInsets.only(right: 50),
                child: IconButton(
                  icon: Icon(Icons.adjust),
                  color: Colors.blueAccent,
                  onPressed: () {
                    setState(() {
                      taskColors[widget.i] = Colors.blueAccent;
                      taskImportance[widget.i] = 1;
                      Navigator.of(context).pop();
                    });
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 55),
                child: IconButton(
                  icon: Icon(Icons.adjust),
                  color: Colors.yellowAccent,
                  onPressed: () {
                    setState(() {
                      taskColors[widget.i] = Colors.yellowAccent;
                      taskImportance[widget.i] = 1.5;
                      Navigator.of(context).pop();
                    });
                  },
                ),
              ),
              Container(
                child: IconButton(
                  icon: Icon(Icons.adjust),
                  color: Colors.redAccent,
                  onPressed: () {
                    setState(() {
                      taskColors[widget.i] = Colors.redAccent;
                      taskImportance[widget.i] = 2;
                      Navigator.of(context).pop();
                    });
                  },
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: taskColors[widget.i],
      ),
      margin: EdgeInsets.all(5),
      height: 60 * taskImportance[widget.i],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: IconButton(
              onPressed: _toggleChecked,
              icon: taskPressed[widget.i]
                  ? Icon(Icons.check_box)
                  : Icon(Icons.check_box_outline_blank),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: _changeTaskName,
              child: Container(
                child: Center(
                  child: Text(taskName[widget.i]),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: _displaySizeChangeDialog,
            ),
          ),
        ],
      ),
    );
  }
}
