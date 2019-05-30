import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(debugShowCheckedModeBanner: false, home: AllTasksPage()),
    );

class AllTasksPage extends StatefulWidget {
  AllTasksPage({Key key}) : super(key: key);

  _AllTasksPageState createState() => _AllTasksPageState();
}

class _AllTasksPageState extends State<AllTasksPage> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> _tasks = List.generate(_count, (int i) => TaskColumn());

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
                  child: ListView(
                    children: _tasks,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewTask,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _addNewTask() {
    setState(() {
      _count++;
    });
  }
}

class TaskColumn extends StatefulWidget {
  TaskColumn({int count, Key key})
      : this.count = count,
        super(key: key);
  final count;

  _TaskColumnState createState() => _TaskColumnState();
}

class _TaskColumnState extends State<TaskColumn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blueAccent,
      ),
      margin: EdgeInsets.all(5),
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 120),
              child: Center(
                child: Text('task'),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 150),
            child: IconButton(
              onPressed: null,
              icon: Icon(Icons.clear),
            ),
          ),
        ],
      ),
    );
  }
}
