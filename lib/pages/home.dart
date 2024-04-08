import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Dio dio = Dio();
  String apiUrl = "https://jsonplaceholder.typicode.com/posts";
  List<dynamic> posts = [];

  Future<void> getPost() async {
    try {
      Response response = await dio.get(apiUrl);
      setState(() {
        posts = response.data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(widget.title),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: ListView.separated(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final data = posts[index];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(child: Text(index.toString())),
                  title: Text(data['title']),
                  subtitle: Text(data['body']),
                  titleTextStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(
              height: 10,
            ),
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
