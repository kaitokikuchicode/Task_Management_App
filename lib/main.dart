import 'package:flutter/material.dart';
import 'dart:async';

List<Task> tasks = [];
/*
List<bool> pressed = [];
List<double> importance = [];
List<Color> colors = [];
List<String> keys = [];
*/

void main() => runApp(
      MaterialApp(debugShowCheckedModeBanner: false, home: AllTasksPage()),
    );

class AllTasksPage extends StatefulWidget {
  AllTasksPage({Key key}) : super(key: key);

  _AllTasksPageState createState() => _AllTasksPageState();
}

class _AllTasksPageState extends State<AllTasksPage> {
  int i = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Task Management'),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                    child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                      key: ObjectKey(tasks[index]),
                      onDismissed: (direction) {
                        setState(() {
                          tasks.removeAt(index);
                        });
                      },
                      child: tasks[index],
                    );
                  },
                )),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _addTask() {
    setState(() {
      tasks.add(Task(
        i: i,
      ));
      i++;
    });
  }
}

class Task extends StatefulWidget {
  const Task({int i, Key key})
      : i = i,
        super(key: key);
  final int i;

  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  Color _taskColor = Colors.blueAccent;
  bool _checked = false;
  double _importance = 1;

  void _toggleChecked() {
    setState(() {
      if (_checked) {
        _checked = false;
      } else {
        _checked = true;
      }
    });
  }

  Future<Null> _displaySizeChangeDialog() {
    return showDialog<Null>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            actions: <Widget>[
              Container(
                padding: EdgeInsets.only(right: 50),
                child: IconButton(
                  icon: Icon(Icons.adjust),
                  color: Colors.blueAccent,
                  onPressed: () {
                    setState(() {
                      _taskColor = Colors.blueAccent;
                      _importance = 1;
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
                      _taskColor = Colors.yellowAccent;
                      _importance = 1.5;
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
                      _taskColor = Colors.redAccent;
                      _importance = 2;
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
        color: _taskColor,
      ),
      margin: EdgeInsets.all(5),
      height: 60 * _importance,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            //padding: EdgeInsets.only(left: 150),
            child: IconButton(
              onPressed: _toggleChecked,
              icon: _checked
                  ? Icon(Icons.check_box)
                  : Icon(Icons.check_box_outline_blank),
            ),
          ),
          Expanded(
            child: InkWell(
              onLongPress: null,
              child: Container(
                child: Center(
                  child: Text('task${widget.i}'),
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
