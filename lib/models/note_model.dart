class NoteModel{
  final String title;
  final String description;
  DateTime time  = DateTime.now();

  NoteModel({required this.description, required this.title});
}