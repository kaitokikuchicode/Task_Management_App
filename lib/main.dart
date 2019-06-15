import 'package:flutter/material.dart';

import './task.dart';

List<Task> tasks = [];

Map<int, bool> taskPressed = {};
Map<int, double> taskImportance = {};
Map<int, Color> taskColors = {};
Map<int, String> taskName = {};

String progress = '0%';

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
        title: Text('Task Management'),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 30),
            child: Container(
              padding: EdgeInsets.only(top: 25),
              child: Text(progress),
            ),
          )
        ],
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
                          taskPressed.remove(tasks[index].i);
                          taskImportance.remove(tasks[index].i);
                          taskColors.remove(tasks[index].i);
                          taskName.remove(tasks[index].i);
                          tasks.removeAt(index);
                          calculateProgress();
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
        parent: this,
      ));
      taskPressed[i] = false;
      taskImportance[i] = 1;
      taskColors[i] = Colors.blueAccent;
      taskName[i] = 'task$i';
      calculateProgress();
      i++;
    });
  }

  void calculateProgress() {
    int j = 0;
    setState(() {
      if (taskPressed.isNotEmpty) {
        taskPressed.forEach((key, value) => {value ? j++ : null});
        progress = (((j / taskPressed.length) * 100).round()).toString() + '%';
      } else {
        progress = "0%";
      }
    });
  }
}
