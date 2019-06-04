import 'package:flutter/material.dart';
import 'dart:async';

List<Widget> tasks = [];
List<String> keys = [];
int i = 0;

void main() => runApp(
      MaterialApp(debugShowCheckedModeBanner: false, home: AllTasksPage()),
    );

class AllTasksPage extends StatefulWidget {
  AllTasksPage({Key key}) : super(key: key);

  _AllTasksPageState createState() => _AllTasksPageState();
}

class _AllTasksPageState extends State<AllTasksPage> {
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
                    tasks.map((task) => Data(task)).toList();
                    print(keys[index]);
                    return Dismissible(
                      key: Key(keys[index]),
                      onDismissed: (direction) {
                        setState(() {
                          tasks = tasks.removeAt(index) as List<Widget>;
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
      tasks.add(Task());
      keys.add('$i');
      i++;
    });
  }
}

class Data<T> {
  final T data;
  Data(this.data);
}

class Task extends StatefulWidget {
  const Task({Key key}) : super(key: key);

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
              onLongPress: _displaySizeChangeDialog,
              child: Container(
                child: Center(
                  child: Text('task'),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(Icons.clear),
              onPressed: null,
            ),
          ),
        ],
      ),
    );
  }
}
