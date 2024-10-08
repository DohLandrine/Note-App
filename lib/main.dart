import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pets/firebase_options.dart';
import 'package:pets/presenter/note_provider.dart';
import 'package:pets/views/add_edit_note_page.dart';
import 'package:pets/views/homepage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NoteProvider>(
            create: (context) => NoteProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/homepage': (context) => const Homepage(),
          '/add_edit_note_page.dart': (context) => const AddEditNotePage(),
        },
        home: const Homepage(),
      ),
    );
  }
}
