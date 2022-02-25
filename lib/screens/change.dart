import 'package:flutter/material.dart';
import 'package:russian_gold/components/desk_txt_field.dart';
import 'package:russian_gold/components/name_txt_field.dart';
import 'package:russian_gold/components/person.dart';
import 'package:russian_gold/model/data.dart';

class ChangePage extends StatefulWidget {
  final int index;
  final Person person;
  const ChangePage({Key? key, required this.index, required this.person})
      : super(key: key);

  @override
  State<ChangePage> createState() => _ChangePageState();
}

class _ChangePageState extends State<ChangePage> {
  late TextEditingController nameEditingController;
  late TextEditingController deskEditingController;
  late int post = widget.person.post;
  late bool _war = widget.person.war;
  late bool _league = widget.person.league;

  @override
  void initState() {
    nameEditingController = TextEditingController.fromValue(
        TextEditingValue(text: widget.person.name));
    deskEditingController = TextEditingController.fromValue(
        TextEditingValue(text: widget.person.description!));
    super.initState();
  }

  @override
  void dispose() {
    nameEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(8),
        children: [
          NameTextField(controller: nameEditingController),
          const SizedBox(
            height: 8,
          ),
          DescriptionTextField(controller: deskEditingController),
          const SizedBox(
            height: 8,
          ),
          Wrap(
            spacing: 10,
            runSpacing: 6,
            children: [
              ChoiceChip(
                label: const Text('Глава'),
                selectedColor: Colors.blue,
                selected: post == 0,
                onSelected: (value) {
                  setState(() {
                    post = 0;
                  });
                },
              ),
              ChoiceChip(
                label: const Text('Соруководитель'),
                selectedColor: Colors.blue,
                selected: post == 1,
                onSelected: (value) {
                  setState(() {
                    post = 1;
                  });
                },
              ),
              ChoiceChip(
                label: const Text('Старейшина'),
                selectedColor: Colors.blue,
                selected: post == 2,
                onSelected: (value) {
                  setState(() {
                    post = 2;
                  });
                },
              ),
              ChoiceChip(
                label: const Text('Новичок'),
                selectedColor: Colors.blue,
                selected: post == 3,
                onSelected: (value) {
                  setState(() {
                    post = 3;
                  });
                },
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Участвует?', style: Theme.of(context).textTheme.headline6),
              Row(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () {
                      setState(() {
                        _war = !_war;
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: _war ? Colors.blue : Colors.grey,
                      child: const Text('КВ'),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () {
                      setState(() {
                        _league = !_league;
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: _league ? Colors.blue : Colors.grey,
                      child: const Text('ЛВК'),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          ElevatedButton(
              onPressed: () {
                nameEditingController.text.isNotEmpty
                    ? setState(() {
                        persons[widget.index] = Person(
                            name: nameEditingController.text,
                            description: deskEditingController.text,
                            post: post,
                            league: _league,
                            war: _war);
                        setData();
                        nameEditingController.clear();
                        deskEditingController.clear();
                      })
                    : null;
                Navigator.pop(context);
              },
              child: const Text(
                'Изменить',
              )),
        ],
      ),
    );
  }
}
