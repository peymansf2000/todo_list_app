import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_list_app/main.dart';
import 'package:todo_list_app/models.dart';

import 'editTaskScreen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return SafeArea(
      child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: Column(
            children: [
              Container(
                height: 124,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  themeData.colorScheme.primary,
                  themeData.colorScheme.primaryContainer
                ])),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'To Do List',
                            style: themeData.textTheme.titleLarge,
                          ),
                          const Icon(
                            CupertinoIcons.share,
                            color: Colors.white,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(28),
                          child: TextField(
                            controller: _controller,
                            onChanged: (value) {
                              setState(() {});
                            },
                            decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  CupertinoIcons.search,
                                  color: secondaryTextColor,
                                ),
                                hintText: 'Search Tasks',
                                filled: true,
                                fillColor: themeData.colorScheme.onPrimary,
                                border: InputBorder.none),
                          ))
                    ],
                  ),
                ),
              ),
              StreamBuilder(
                stream: objectbox.getTasksCount(),
                builder: (context, snapshot) => objectbox.isTaskBoxEmpty()
                    ? const emptyTaskState()
                    : Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: themeData.colorScheme.background),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Today',
                                        style: themeData.textTheme.titleSmall
                                            ?.copyWith(fontSize: 17),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 4),
                                        width: 70,
                                        height: 3,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(28),
                                            color:
                                                themeData.colorScheme.primary),
                                      )
                                    ],
                                  ),
                                  MaterialButton(
                                    onPressed: () => showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: const Text('Delete all Tasks'),
                                        content: const Text(
                                            'Do you want to delete all the tasks?'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context, 'No');
                                            },
                                            child: const Text('No'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context, 'Yes');
                                              objectbox.removeAllTasks();
                                            },
                                            child: const Text('Yes'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    color: const Color(0xFFEAEFF5),
                                    textColor: secondaryTextColor,
                                    elevation: 0,
                                    child: const Row(
                                      children: [
                                        Text('Delete All'),
                                        Icon(CupertinoIcons.delete_solid)
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
              Flexible(
                child: StreamBuilder<List<Task>>(
                    stream: objectbox.getTasks(),
                    builder: (context, snapshot) => objectbox.isTaskBoxEmpty()
                        ? const SizedBox.shrink()
                        : ListView.builder(
                            padding: const EdgeInsets.only(bottom: 80),
                            itemBuilder: (context, index) => TaskCard(
                              task: objectbox.searchTasks(_controller.text)[index],
                            ),
                            itemCount: objectbox.searchTasks(_controller.text).length,
                          )),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditTaskScreen(
                          task: Task(),
                        )),
              );
            },
            label: const Row(
              children: [
                Text('Add New Task'),
                SizedBox(
                  width: 4,
                ),
                Icon(Icons.add_circle_outline)
              ],
            ),
          )),
    );
  }
}

class TaskCard extends StatefulWidget {
  const TaskCard({super.key, required this.task});
  final Task task;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    late Color selectedPriorityColor;

    switch (widget.task.priority) {
      case (0):
        selectedPriorityColor = lowPriorityColor;
        break;
      case (1):
        selectedPriorityColor = normalPriorityColor;
        break;
      case (2):
        selectedPriorityColor = highPriorityColor;
        break;
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 3, 16, 0),
      child: Stack(
        children: [
          ListTile(
            onLongPress: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Delete the Task'),
                content: const Text('Do you want to delete this task?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, 'No');
                    },
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, 'Yes');
                      objectbox.removeTask(task: widget.task);
                    },
                    child: const Text('Yes'),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditTaskScreen(
                          task: widget.task,
                        )),
              );
            },
            tileColor: themeData.colorScheme.onPrimary,
            leading: Checkbox(
                shape: const CircleBorder(),
                value: widget.task.isCompleted,
                onChanged: (bool? value) {
                  setState(() {
                    widget.task.isCompleted = value!;
                    objectbox.updateTask(task: widget.task);
                  });
                }),
            title: Expanded(
                child: Text(
              style: widget.task.isCompleted
                  ? const TextStyle(decoration: TextDecoration.lineThrough)
                  : null,
              widget.task.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )),
          ),
          Positioned(
              right: 0,
              bottom: 0,
              top: 0,
              child: Container(
                width: 6,
                decoration: BoxDecoration(color: selectedPriorityColor),
              ))
        ],
      ),
    );
  }
}

class emptyTaskState extends StatelessWidget {
  const emptyTaskState({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/img/empty_state.svg',
            width: 150,
          ),
          const SizedBox(
            height: 25,
          ),
          const Text('Your Task list is Empty')
        ],
      ),
    );
  }
}
