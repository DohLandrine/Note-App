import 'package:flutter/material.dart';
import 'package:pets/constants/theme.dart';
import 'package:pets/models/note_model.dart';
import 'package:pets/services/cloud_database_service.dart';

class AddEditNotePage extends StatefulWidget {
  final Map<String, dynamic>? note;
  final int? index;
  final bool? newNote;
  const AddEditNotePage({super.key, this.index, this.note, this.newNote});

  @override
  State<AddEditNotePage> createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {
  String? title;
  String? description;

  @override
  void initState() {
    title = widget.newNote! ? widget.note!['title'] : null;
    description = widget.newNote! ? widget.note!['description'] : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colour.dark,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colour.white, size: 35),
        backgroundColor: Colour.dark,
        title: Text(
          widget.newNote! ? 'New note' : 'Edit Note',
          style: CustomTextStyle.heading,
        ),
      ),
      body: Stack(children: [
        ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.newNote! ? '${DateTime.now()}' : '${widget.note!['time']}',
              style: CustomTextStyle.title,
            ),
            const SizedBox(
              height: 20,
            ),
            ListView(shrinkWrap: true, children: [
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      initialValue:
                          widget.newNote! ? null : widget.note!['title'],
                      onChanged: (value) => title = value,
                      style: CustomTextStyle.heading
                          .copyWith(fontWeight: FontWeight.w200),
                      cursorColor: Colour.blue,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Title',
                        labelStyle: CustomTextStyle.heading
                            .copyWith(fontWeight: FontWeight.w300),
                      ),
                      cursorHeight: 40,
                      maxLength: 120,
                      maxLines: 1,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      initialValue:
                          widget.newNote! ? null : widget.note!['description'],
                      onChanged: (value) => description = value,
                      style: const TextStyle(
                          color: Colour.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w300),
                      cursorColor: Colour.blue,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Note something down',
                        hintStyle: TextStyle(
                          color: Color.fromARGB(255, 129, 110, 110),
                          fontSize: 25,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      cursorHeight: 40,
                      maxLength: 10000,
                      maxLines: 100,
                    ),
                  ],
                ),
              ),
            ]),
          ],
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: RawMaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onPressed: () {
              CloudDatabaseService.instance.addNotes(title!, description!);
            },
            fillColor: Colour.blue,
            child: const Text(
              'Done',
              style: CustomTextStyle.title,
            ),
          ),
        )
      ]),
    );
  }
}
