import 'package:flutter/material.dart';
import 'package:russian_gold/components/person.dart';

class PersonPage extends StatelessWidget {
  final Person person;
  const PersonPage({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(person.name),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Участвует в',
                style: Theme.of(context).textTheme.headline6,
              ),
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: person.war ? Colors.green : Colors.red,
                    child:
                        const Text('КВ', style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  CircleAvatar(
                    backgroundColor: person.league ? Colors.green : Colors.red,
                    child: const Text('ЛВК',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
          person.description!.isNotEmpty
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    'Описание',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Text(
              person.description!,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
