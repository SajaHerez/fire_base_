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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
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
                    await langServ.getLang(nameController.text);
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
