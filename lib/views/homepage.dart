import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pets/constants/theme.dart';
import 'package:pets/presenter/note_provider.dart';
import 'package:pets/views/add_edit_note_page.dart';
import 'package:provider/provider.dart';
import 'package:pets/services/cloud_database_service.dart';
import 'package:intl/intl.dart' as intl;

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final firestoreinstance = CloudDatabaseService.instance;
  @override
  Widget build(BuildContext context) {
    //var providerInstance = Provider.of<NoteProvider>(context);
    return Scaffold(
      backgroundColor: Colour.dark,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: ListView(
          // mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 70),
            const Text(
              'Notes',
              style: CustomTextStyle.heading,
            ),
            const Text(
              'implement search here',
              style: CustomTextStyle.title,
            ),
            StreamBuilder(
                stream: firestoreinstance.notes,
                builder: (context, snapshots) {
                  if (snapshots.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(
                      color: Colour.blue,
                    );
                  } else if (snapshots.hasError) {
                    return Container(
                      alignment: Alignment.center,
                      child: const Text(
                        "An error occured",
                        style: TextStyle(color: Colors.red, fontSize: 30),
                      ),
                    );
                  } else {
                    return ListView.separated(
                      shrinkWrap: true,
                      itemCount: snapshots.data!.docs.length,
                      itemBuilder: (context, index) {
                        DateTime time =
                            snapshots.data!.docs[index]['time'].toDate();
                        var day = intl.DateFormat.MMMd().format(time);
                        var hour_min = intl.DateFormat.Hm().format(time);
                        return ListTile(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddEditNotePage(
                                  index: index,
                                  newNote: false,
                                  note: {
                                    'time': time,
                                    'title': snapshots.data!.docs[index]
                                        ['title'],
                                    'description': snapshots.data!.docs[index]
                                        ['description']
                                  },
                                ),
                              )),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: const BorderSide(color: Colour.blue)),
                          tileColor: Colour.lightDark,
                          title: Text(
                            '${snapshots.data!.docs[index]['title']}',
                            style: CustomTextStyle.title,
                          ),
                          trailing: Text('$day $hour_min',
                              style: const TextStyle(color: Colour.dark)),
                          subtitle: Text(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            '${snapshots.data!.docs[index]['description']}',
                            style: const TextStyle(color: Colour.white),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                    );
                  }
                })
          ],
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: RawMaterialButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddEditNotePage(
                          newNote: true,
                        )));
          },
          fillColor: Colour.blue,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(10),
          child: const Icon(
            size: 40,
            Icons.add,
            color: Colour.white,
          ),
        ),
      ),
    );
  }
}
