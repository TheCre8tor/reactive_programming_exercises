import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:who_to_follow/modules/user/repositories/user_repository.dart';
import 'package:who_to_follow/modules/user/services/http/user_service.dart';
import 'package:who_to_follow/modules/user/usecases/get_users.dart';
import 'package:who_to_follow/screens/user_suggestions/bloc/user_suggestion_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final UserSuggestionBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = UserSuggestionBloc(
      usecase: GetUsers(
        repository: UserRepository(
          service: UserService(
            client: Client(),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder(
              stream: bloc.users,
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data?.length);
                }

                if (snapshot.hasError) {
                  print("Error state: ${snapshot.error}");
                }

                return const Text("data");
              }),
            ),
            const SizedBox(height: 30),
            TextButton(
              onPressed: () {
                bloc.getUsers.add(null);
              },
              child: const Text("Press Button"),
            )
          ],
        ),
      ),
    );
  }
}
