import 'package:flutter/material.dart';
import 'databasehelper.dart';

class UpdateUser extends StatefulWidget {
  const UpdateUser({super.key, required this.userId});

  final int userId;

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();

  void fetchData() async{
    Map<String, dynamic>? data = await DatabaseHelper.getSingleData(widget.userId);
    if(data != null){
      _nameController.text = data['name'];
      _ageController.text = data['age'].toString();
    }
  }

  void _updateData(context) async{
    Map<String, dynamic> data = {
      'name' : _nameController.text,
      'age' : _ageController.text,
    };
    int id = await DatabaseHelper.updateData(widget.userId, data);
    Navigator.pop(context, true);
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Update user'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(hintText: 'Name'),
            ),
            TextFormField(
              controller: _ageController,
              decoration: const InputDecoration(hintText: 'Age'),
            ),
            ElevatedButton(
                onPressed: () => _updateData(context),
                child: const Text('Update'))
          ],
        ),
      ),
    );
  }
}

