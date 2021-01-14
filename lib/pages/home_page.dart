import 'package:flutter/material.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/services/item_service.dart';
import 'new_task_page.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Task>> taskList;

  @override
  void initState() {
    super.initState();
    taskList = ItemService().getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lets get these done with...'),
      ),
      body: FutureBuilder<List<Task>>(
        future: taskList,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            if(snapshot.data.isEmpty){
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/pic.png'),
                    Text('All Tasks Completed!!!')
                  ],
                ),
              );
            }
            else{
              return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return ListTile(
                    leading: Icon(Icons.notes),
                    title: Text(snapshot.data[index].title),
                    subtitle: Text(snapshot.data[index].content),
                    trailing: IconButton(
                      icon: Icon(Icons.delete), 
                      onPressed: () async {
                        await ItemService().deleteTask(index: index);
                        setState(() {
                          taskList = ItemService().getTasks();
                        });
                      }
                    ),
                  );
                },
              );
            }
          }
          else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'new',
        onPressed: (){
          Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new NewTaskPage())).then((value) {
          setState(() {
            taskList = ItemService().getTasks();
          });});
        }, 
        label: Text('New Task'),
        icon: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}