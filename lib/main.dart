import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<String> subjects = [
    "A Architektura rozwiązań chmurowych - Kwolek Bartosz, Konieczny Marek",
    "B Metody rozpoznawania obrazów - Dzwinel Witold",
    "C Ochrona danych w społeczeństwie cyfrowym - Golizda-Bliziński Marcin",
    "D Optymalizacja kodu na różne architektury - Woźniak Maciej",
    "E Programowanie autonomicznych robotów mobilnych - Turek Wojciech",
    "F Programowanie reaktywne w języku Scala - Baliś Bartosz",
    "G Systemy CAD/CAE - Paszyński Maciej",
    "H Systemy rekomendacyjne - Marcin Kurdziel, Piotr Ociepka",
    "I Wirtualne sieci prywatne - Zieliński Sławomir",
  ];

  void updateSubjectsOrder(oldIndex, newIndex) {
    setState(() {
      final subject = subjects.removeAt(oldIndex);
      if (newIndex > oldIndex) newIndex = newIndex == 0 ? 0 : newIndex - 1;
      subjects.insert(newIndex, subject);
    });
  }

  void openImportModal() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('Paste your subjects below'),
              content: TextField(
                minLines: null,
                maxLines: null,
                expands: true,
                onChanged: (value) {
                  List<String> newSubjects = value.split("\n");
                  setState(() {
                    subjects = newSubjects;
                  });
                },
              ),
            ));
  }

  void openExportModal() {
    String preferences = subjects.map((s) => s[0]).join();
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Your preferences"),
              content: new Text(preferences),
              actions: [
                ElevatedButton.icon(
                  onPressed: () =>
                      Clipboard.setData(new ClipboardData(text: preferences)),
                  icon: Icon(Icons.copy),
                  label: Text("Copy to clipboard"),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            ElevatedButton(
                onPressed: openImportModal,
                child: Icon(Icons.arrow_circle_down)),
            ElevatedButton(
                onPressed: openExportModal, child: Icon(Icons.arrow_circle_up)),
          ],
        ),
        body: Center(
          child: ReorderableListView(
            onReorder: updateSubjectsOrder,
            header: Text("Reorder subjects to your need!"),
            children: [
              for (final subject in subjects)
                ListTile(
                  key: ValueKey(subject),
                  title: Text(subject),
                )
            ],
          ),
        ));
  }
}
