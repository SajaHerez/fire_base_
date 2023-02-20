import 'package:flutter/material.dart';
import '../ex1/home_page.dart';
import 'language_services.dart';

class CongigScreen extends StatefulWidget {
  CongigScreen({super.key});
  @override
  State<CongigScreen> createState() => _CongigScreenState();
}

class _CongigScreenState extends State<CongigScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController likesController = TextEditingController();
  final LangServices langServ = LangServices();
  String langname = '';
  String likes = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cloud Firestore'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (langname.isNotEmpty)
            Text(
              'LanguageName: $langname  , Likes :$likes',
              style: const TextStyle(fontSize: 25),
            ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            decoration: const InputDecoration(
              labelText: 'name',
            ),
            controller: nameController,
          ),
          TextField(
            decoration: const InputDecoration(
              labelText: 'likes',
            ),
            keyboardType: TextInputType.number,
            controller: likesController,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    await langServ.addLanguage(
                        nameController.text, int.parse(likesController.text));
                    nameController.clear();
                    likesController.clear();
                  },
                  child: const Text('add')),
              ElevatedButton(
                  onPressed: () async {
                    await langServ.updateLanguage(
                        nameController.text, int.parse(likesController.text));
                    nameController.clear();
                    likesController.clear();
                  },
                  child: const Text('update')),
              ElevatedButton(
                  onPressed: () async {
                    await langServ.deleteLanguage(nameController.text);
                    nameController.clear();
                    likesController.clear();
                  },
                  child: const Text('remove')),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    final lang = await langServ.getLang(nameController.text);
                    setState(() {
                      langname = lang.docs.first['name'];
                      print(lang.docs.first['name']);
                      likes = lang.docs.first['likes'].toString();
                      print(lang.docs.first['likes']);
                    });
                  },
                  child: const Text('read one')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) {
                      return const MyHomePage(
                        title: 'home page',
                      );
                    })));
                  },
                  child: const Text('read all'))
            ],
          )
        ],
      ),
    );
  }
}
