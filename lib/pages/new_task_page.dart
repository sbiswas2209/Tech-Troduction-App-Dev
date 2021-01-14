import 'package:flutter/material.dart';
import 'package:to_do/services/item_service.dart';
class NewTaskPage extends StatefulWidget {
  @override
  _NewTaskPageState createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {

  final TextEditingController _title = TextEditingController();
  final TextEditingController _content = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Add New Task'),
      ),
      body: _isLoading ? Center(child: CircularProgressIndicator()) : Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _title,
                decoration: InputDecoration(
                  labelText: 'Add Title',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _content,
                decoration: InputDecoration(
                  labelText: 'Add Content',
                  border: OutlineInputBorder()
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if(_title.text.isEmpty || _content.text.isEmpty){
            _scaffoldKey.currentState.showSnackBar(const SnackBar(content: Text('Please fill both fields')));
          }
          else{
            setState(() {
              _isLoading = !_isLoading;
            });
            await ItemService().saveTask(title: _title.text, content: _content.text);
            setState(() {
              _isLoading = !_isLoading;
            });
            Navigator.pop(context);
          }
        },
        child: Icon(Icons.save),
      ),
    );
  }
}