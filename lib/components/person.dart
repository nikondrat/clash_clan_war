import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:russian_gold/model/data.dart';
import 'package:russian_gold/screens/change.dart';
import 'package:russian_gold/screens/person.dart';

List posts = ['Глава', 'Соруководитель', 'Старейшина', 'Новичок'];

class Person {
  String name;
  bool war;
  bool league;
  String? description;
  int post;
  Person(
      {required this.name,
      required this.war,
      required this.league,
      this.description,
      required this.post});

  Person.fromJson(data)
      : name = data['name'] as String,
        war = data['war'] ?? false,
        league = data['league'] ?? false,
        post = data['post'] as int,
        description = data['description'] ?? '';

  Map<String, dynamic> toJson() => {
        'name': name,
        'war': war,
        'league': league,
        'post': post,
        'description': description
      };
}

class PersonElement extends StatefulWidget {
  final int index;
  final Person person;
  const PersonElement({
    Key? key,
    required this.index,
    required this.person,
  }) : super(key: key);

  @override
  State<PersonElement> createState() => _PersonElementState();
}

class _PersonElementState extends State<PersonElement> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(motion: const ScrollMotion(), children: [
        SlidableAction(
            onPressed: (context) => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => ChangePage(
                    index: widget.index,
                    person: widget.person,
                  ),
                )),
            backgroundColor: Colors.blue,
            icon: Icons.manage_accounts,
            label: 'Изменить'),
      ]),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              setState(() {
                persons.removeAt(widget.index);
                setData();
              });
            },
            backgroundColor: Colors.red,
            icon: Icons.delete_outline,
            label: 'Убрать',
          ),
        ],
      ),
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.person.name,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  posts[widget.person.post],
                  style: TextStyle(color: Colors.grey.shade600),
                )
              ],
            ),
            Row(
              children: [
                CircleAvatar(
                  child: const Text(
                    'КВ',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor:
                      widget.person.war ? Colors.green : Colors.red,
                ),
                const SizedBox(
                  width: 8,
                ),
                CircleAvatar(
                  child: const Text(
                    'ЛВК',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor:
                      widget.person.league ? Colors.green : Colors.red,
                ),
              ],
            )
          ]),
        ),
        onTap: () => Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => PersonPage(
                person: widget.person,
              ),
            )),
      ),
    );
  }
}
