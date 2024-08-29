import 'package:flutter/material.dart';
import 'package:pets/models/note_model.dart';
class NoteProvider extends ChangeNotifier{
  // ignore: prefer_final_fields
  List<NoteModel> _notes = [
      NoteModel(description: 'Here is my description for the note model', title: 'Here is my title'),
      NoteModel(description: 'Description should be here', title: 'Title should be here'),
  ];

  List<NoteModel> get getNotes => _notes;

  void addNotes(String title, String description){
    _notes.add(
      NoteModel(description: description, title: title)
    );
    notifyListeners();
  } 

  void deleteNotes(int index){
    _notes.removeAt(index);
  }

  void updateNotes(int index, String title, String description){
    _notes.replaceRange(index, index+1, NoteModel(description: description, title: title) as Iterable<NoteModel>);
  }

}