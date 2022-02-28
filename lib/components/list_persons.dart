import 'package:flutter/material.dart';
import 'package:russian_gold/components/person.dart';
import 'package:russian_gold/model/data.dart';

class ListPersons extends StatefulWidget {
  const ListPersons({Key? key}) : super(key: key);

  @override
  State<ListPersons> createState() => _ListPersonsState();
}

class _ListPersonsState extends State<ListPersons> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
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
                            description: persons[index].description,
                            post: persons[index].post)),
                  ),
              itemCount: persons.length,
              onReorder: (int oldIndex, int newIndex) {
                setState(() {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  Person oldPerson = persons.removeAt(oldIndex);
                  persons.insert(newIndex, oldPerson);
                  setData();
                });
              });
        });
  }
}
