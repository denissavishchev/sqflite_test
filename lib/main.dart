import 'package:flutter/material.dart';
import 'package:sqflite_test/update_user.dart';
import 'databasehelper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  List<Map<String, dynamic>> dataList = [];

  void _saveData() async{
    final name = _nameController.text;
    final age = int.tryParse(_ageController.text) ?? 0;
    int insertId = await DatabaseHelper.insertUser(name, age);
    _fetchUsers();
    _nameController.text = '';
    _ageController.text = '';
  }

  void _fetchUsers()async {
    List<Map<String, dynamic>> userList = await DatabaseHelper.getData();
    setState(() {
      dataList = userList;
    });
  }

  void fetchData()async {
    List<Map<String, dynamic>> fetchedData = await DatabaseHelper.getData();
    setState(() {
      dataList = fetchedData;
    });
  }

  void _delete(int docId) async{
    int id = await DatabaseHelper.deleteData(docId);
    List<Map<String, dynamic>> updatedData = await DatabaseHelper.getData();
    setState(() {
      dataList = updatedData;
    });
  }

  @override
  void initState() {
    _fetchUsers();
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Column(
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
                      onPressed: _saveData,
                      child: const Text('Save'))
                ],
              ),
              const SizedBox(height: 30,),
              Expanded(
                  child: ListView.builder(
                    itemCount: dataList.length,
                      itemBuilder: (context, index){
                        return ListTile(
                          title: Text(dataList[index]['name']),
                          subtitle: Text('Age: ${dataList[index]['age']}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () => Navigator.push(context,
                                    MaterialPageRoute(builder: (context) =>
                                    UpdateUser(userId: dataList[index]['id']))).then((result) {
                                    if(result == true) {
                                      fetchData();
                                    }
                                }),
                                icon: const Icon(Icons.edit, color: Colors.green,),),
                              IconButton(
                                onPressed: () => _delete(dataList[index]['id']),
                                icon: const Icon(Icons.delete, color: Colors.red,),),
                            ],
                          ),
                        );
                      }))
            ],
          ),
        ),
      ),
    );
  }
}


