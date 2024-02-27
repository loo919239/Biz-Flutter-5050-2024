import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/models/todo.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  List<Todo> todoList = [];

  @override
  void initState() {
    super.initState();
    // todoList.add(getTodo("Start"));
    // todoList.add(getTodo("Second"));
    // todoList.add(getTodo("Third"));
  }

  Todo getTodo(String content) {
    return Todo(
      sdate: DateFormat("yyyy-MM-dd").format(DateTime.now()),
      stime: DateFormat("HH:mm:ss").format(DateTime.now()),
      content: content,
      complete: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: Image.asset(
          "assets/user.png",
          fit: BoxFit.fill,
        ),
        title: const Text("TODO"),
        actions: [
          IconButton(
            onPressed: _showTodoInputDialog,
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () => {_showTodoInputDialog()}, // 이건 값을 넘겨주는 방식
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () => {},
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          // 옆으로 밀면 사라딤
          return Dismissible(
              key: UniqueKey(),
              background: Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                color: Colors.green,
                alignment: Alignment.centerLeft,
                child: const Icon(
                  Icons.save_alt_sharp,
                  size: 36,
                  color: Colors.white,
                ),
              ),
              secondaryBackground: Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: Colors.red,
                alignment: Alignment.centerRight,
                child: const Icon(
                  Icons.delete_outline,
                  size: 36,
                  color: Colors.white,
                ),
              ),
              child: Material(
                child: InkWell(
                  onTap: () => {},
                  highlightColor: Colors.red.withOpacity(0.3),
                  splashColor: Colors.blueAccent.withOpacity(0.3),
                  child: ListTile(
                    title: Row(
                      children: [
                        Column(
                          children: [
                            Text(todoList[index].sdate,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                )),
                            Text(todoList[index].stime,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                )),
                            // Text(todoList[index].content),
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text(todoList[index].content,
                                style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.blue,
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              // 사라지기 전에 실행할 이벤트
              confirmDismiss: (direction) {
                if (direction == DismissDirection.endToStart) {
                  return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("삭제할까요?"),
                        actions: [
                          ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text("예"),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text("취소"),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  return Future.value(false);
                }
                // return Future.value(true);
              },
              // 사라진 후에 실행할 이벤트
              onDismissed: (direction) => {
                    if (direction == DismissDirection.endToStart)
                      {
                        setState(() {
                          todoList.removeAt(index);
                        })
                      }
                  });
        },
      ),
    );
  }

  Future<void> _showTodoInputDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("할일 등록"),
          content: _todoInputBox(context),
        );
      },
    );
  }

  /// Expanded Widget
  /// Column, Row 등으로 Widget 을 감싸면 content 가 없는 경우
  /// Widget 이 화면에서 사라져 버리는 경우가 있다
  /// 이때는 그 Widget 을 Expdanded Widget 으로 감싸주면 해결된다.
  Widget _todoInputBox(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            textInputAction: TextInputAction.go,
            decoration: const InputDecoration(hintText: "할일을 입력해 주세요"),
            onSubmitted: (value) {
              setState(() {
                todoList.add(getTodo(value));
              });
              // SnackBar 를 띄우기 위해 SnackBar 객체(변수) 선언
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("할일이 등록됨"),
                ),
              );
              Navigator.of(context).pop();
            },
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.send_outlined),
          ),
        ],
      ),
    );
  }
}
