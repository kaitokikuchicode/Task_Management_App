import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(home: AllTasksPage()),
    );

class AllTasksPage extends StatefulWidget {
  AllTasksPage({Key key}) : super(key: key);

  _AllTasksPageState createState() => _AllTasksPageState();
}

class _AllTasksPageState extends State<AllTasksPage> {
  int _count = 1;

  @override
  Widget build(BuildContext context) {
    List<Widget> _tasks = new List.generate(_count, (int i) => TaskColumn());

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Task Management'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
            ),
            Center(
              child: Container(
                height: 70,
                child: ListView(
                  children: _tasks,
                ),
              ),
            ),
            Center(
              child: Container(
                height: 70,
                child: ListView(
                  children: _tasks,
                ),
              ),
            ),
            Center(
              child: Container(
                height: 70,
                child: ListView(
                  children: _tasks,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class TaskColumn extends StatefulWidget {
  TaskColumn({Key key}) : super(key: key);

  _TaskColumnState createState() => _TaskColumnState();
}

class _TaskColumnState extends State<TaskColumn> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text('Task is here.'),
      ),
    );
  }
}
