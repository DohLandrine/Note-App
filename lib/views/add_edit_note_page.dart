import 'package:flutter/material.dart';
import 'package:pets/constants/theme.dart';
import 'package:pets/constants/widget.dart';
import 'package:pets/models/note_model.dart';
import 'package:pets/presenter/whatsapp_presenter.dart';
import 'package:pets/services/cloud_database_service.dart';
import 'package:intl/intl.dart' as intl;
import 'package:pets/views/homepage.dart';

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
  String? id;

  @override
  void initState() {
    super.initState();
    title = widget.newNote! ? null : widget.note!['title'];
    description = widget.newNote! ? null : widget.note!['description'];
    id = widget.newNote! ? null : widget.note!['id'];
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
          style: CustomTextStyle.heading
              .copyWith(fontSize: 28, color: Colour.blue),
        ),
        actions: widget.newNote!
            ? []
            : [
                GestureDetector(
                  onTap: () async {
                    await WhatsappPresenter.instance.isWhatsappInstalled()
                        ? WhatsappPresenter.instance.shareNoteInWhatsapp(
                            title: widget.note!['title'],
                            description: widget.note!['description'])
                        :
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                            customSnackBar(
                                content: 'Whatsapp not installed',
                                icon: Icons.no_accounts_outlined,
                                colour: Colour.red));
                  },
                  child: const Icon(
                    Icons.share,
                    size: 25,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                PopupMenuButton(
                    itemBuilder: (context) => [
                          PopupMenuItem(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Center(
                              child: Text(
                                'Delete',
                                style: CustomTextStyle.title.copyWith(
                                  color: Colour.dark,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            onTap: () => showDialog(
                              context: context,
                              builder: (context) =>
                                  customDialog(widget.note!['id']),
                            ),
                          )
                        ])
              ],
        centerTitle: widget.newNote! ? true : false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Stack(children: [
          ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                intl.DateFormat.Hm().format(DateTime.now()),
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
                        autofocus: true,
                        initialValue:
                            widget.newNote! ? null : widget.note!['title'],
                        onChanged: (value) => title = value,
                        style: CustomTextStyle.heading.copyWith(
                          fontWeight: FontWeight.w200,
                          fontSize: 22,
                        ),
                        cursorColor: Colour.blue,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Title',
                          labelStyle: CustomTextStyle.heading.copyWith(
                            fontWeight: FontWeight.w200,
                            color: Colour.blue,
                          ),
                        ),
                        cursorHeight: 40,
                        maxLength: 120,
                        maxLines: 1,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Divider(
                        color: Colour.blue,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        initialValue: widget.newNote!
                            ? null
                            : widget.note!['description'],
                        onChanged: (value) => description = value,
                        style: const TextStyle(
                            color: Colour.white,
                            fontSize: 18,
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onPressed: () {
                if (widget.newNote! == true) {
                  CloudDatabaseService.instance.addNotes(title!, description!);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                      content: 'Note added successfully',
                      icon: Icons.mood_rounded,
                      colour: Colour.green));
                } else {
                  CloudDatabaseService.instance
                      .editNote(title!, description!, id!);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                      content: 'Note edited successfully',
                      icon: Icons.mood_rounded,
                      colour: Colour.green));
                }
              },
              fillColor: Colour.darkBlue,
              child: Text(
                widget.newNote! ? 'Done' : 'edit',
                style: CustomTextStyle.title,
              ),
            ),
          )
        ]),
      ),
    );
  }

  Widget customDialog(String? id) {
    return AlertDialog(
      elevation: 10,
      shadowColor: Colors.green,
      backgroundColor: Colour.darkBlue,
      title: Text(
        'Delete',
        style: CustomTextStyle.title.copyWith(
          fontSize: 25,
          fontWeight: FontWeight.w500,
        ),
      ),
      content: Text(
        'Do you want to delete?',
        style: CustomTextStyle.title.copyWith(
          fontSize: 15,
          fontWeight: FontWeight.w300,
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            CloudDatabaseService.instance.deleteNotes(id: widget.note!['id']);
            //   Navigator.popUntil(
            //       context, ModalRoute.withName('/add_edit_note_page.dart.dart'));
            // },
            //   Navigator.removeRoute(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => const AddEditNotePage()));
            Navigator.pop(context);
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(
                  content: 'Note deleted successfully',
                  icon: Icons.thumb_up_alt_outlined,
                  colour: Colour.green),
            );
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(8),
              color: Colour.red,
            ),
            width: 60,
            height: 35,
            child: const Text('Yes'),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(8),
              color: Colour.green,
            ),
            width: 60,
            height: 35,
            child: const Text('No'),
          ),
        )
      ],
    );
  }
}
