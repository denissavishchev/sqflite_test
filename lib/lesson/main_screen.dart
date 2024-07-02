import 'package:flutter/material.dart';

import 'add_note_screen.dart';
import 'notes_repository.dart';


class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: FutureBuilder(
        future: NotesRepository.getData(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              final data = snapshot.data!;
              return Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.all(12),
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(data[index].id.toString()),
                    Text(data[index].title),
                    Text(data[index].description),
                    Text(data[index].createdAt.toString())
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const AddNoteScreen())),
        child: const Icon(Icons.add),
      ),
    );
  }
}
