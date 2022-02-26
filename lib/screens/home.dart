import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:russian_gold/components/person.dart';
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
                    setState(() {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const AddPage(),
                          ));
                    });
                  },
                  icon: const Icon(Icons.add)),
            )
          ],
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
                  ? StreamBuilder(
                      stream: refreshData,
                      builder: (context, snapshot) {
                        return ReorderableListView.builder(
                            physics: const BouncingScrollPhysics(),
                            buildDefaultDragHandles: false,
                            itemBuilder: (context, index) =>
                                ReorderableDelayedDragStartListener(
                                  key: Key('$index'),
                                  index: index,
                                  child: PersonElement(
                                      index: index,
                                      person: Person(
                                          name: persons[index].name,
                                          war: persons[index].war,
                                          league: persons[index].league,
                                          description:
                                              persons[index].description,
                                          post: persons[index].post)),
                                ),
                            itemCount: persons.length,
                            onReorder: (int oldIndex, int newIndex) {
                              setState(() {
                                if (oldIndex < newIndex) {
                                  newIndex -= 1;
                                }
                                Person _oldPerson = persons.elementAt(oldIndex);
                                persons.removeAt(oldIndex);
                                persons.insert(newIndex, _oldPerson);
                                setData();
                                refreshData;
                              });
                            });
                      })
                  : Center(
                      child: Text('Добавьте игроков',
                          style: Theme.of(context).textTheme.bodyLarge),
                    );
            }));
  }
}
