import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:russian_gold/components/list_persons.dart';
import 'package:russian_gold/model/data.dart';
import 'package:russian_gold/screens/add.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('Russian Gold'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  splashRadius: 20,
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const AddPage(),
                        ));
                  },
                  icon: const Icon(Icons.add)),
            )
          ],
          bottom: PreferredSize(
              preferredSize: const Size(double.infinity, 40),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            persons.sort(((a, b) => a.name.compareTo(b.name)));
                            setData();
                          });
                        },
                        child: const Text(
                          'Имя',
                          style: TextStyle(color: Colors.white),
                        )),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            persons.sort(((a, b) => a.post.compareTo(b.post)));
                            setData();
                          });
                        },
                        child: const Text(
                          'Звание',
                          style: TextStyle(color: Colors.white),
                        )),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            persons.sort(
                              (a, b) => a.war ? 0 : 1,
                            );
                            setData();
                          });
                        },
                        child: const Text(
                          'КВ',
                          style: TextStyle(color: Colors.white),
                        )),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            persons.sort(
                              (a, b) => a.league ? 0 : 1,
                            );
                            setData();
                          });
                        },
                        child: const Text(
                          'ЛВК',
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                ),
              )),
        ),
        body: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(
                    child: Text(
                  snapshot.hasError.toString(),
                ));
              }
              return persons.isNotEmpty
                  ? const ListPersons()
                  : Center(
                      child: Text('Добавьте игроков',
                          style: Theme.of(context).textTheme.bodyLarge),
                    );
            }));
  }
}
