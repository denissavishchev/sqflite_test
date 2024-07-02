import 'package:flutter/material.dart';
import 'main_screen.dart';
import 'model.dart';
import 'notes_repository.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {

  final titleTextController = TextEditingController();
  final descriptionTextController = TextEditingController();

  _insertNote() async{
    final note = Model(
        title: titleTextController.text,
        description: descriptionTextController.text,
        createdAt: DateTime.now()
    );
    await NotesRepository.insert(model: note);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 40,),
            Row(
              children: [
                IconButton(
                    onPressed: () => Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => const MainScreen())),
                    icon: const Icon(Icons.arrow_back_ios_new)),
                const Spacer()
              ],
            ),
            const SizedBox(height: 40,),
            TextField(
              controller: titleTextController,
              decoration: InputDecoration(
                hintText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12)
                )
              ),
            ),
            const SizedBox(height: 40,),
            TextField(
              controller: descriptionTextController,
              decoration: InputDecoration(
                  hintText: 'Description',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)
                  )
              ),
            ),
            const SizedBox(height: 40,),
            ElevatedButton(
                onPressed: _insertNote,
                child: const Text('Add'))
          ],
        ),
      ),
    );
  }
}
