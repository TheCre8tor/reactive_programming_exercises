import 'package:flutter/material.dart';
import 'package:ruqe/ruqe.dart';
import 'package:rxdart/rxdart.dart';
import 'package:who_to_follow/screens/user_suggestions/bloc/user_suggestion_bloc.dart';
import 'package:who_to_follow/shared/core/bloc/bloc_provider.dart';

import 'dependency_injection.dart' as dependency_injection;
import 'dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependency_injection.init();

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
      home: BlocProvider(
        bloc: kiwiContainer<UserSuggestionBloc>(),
        child: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<UserSuggestionBloc>(context);

    bloc.refreshedUsers.add(const None());
    bloc.closeUser1.add(const None());

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                const Text("Who to follow"),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        bloc.refreshedUsers.add(const None());
                      },
                      child: const Text("Refresh"),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text("View All"),
                    ),
                  ],
                ),
                StreamBuilder(
                  stream: bloc.user1,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Row(
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Image.network(
                              snapshot.data!.avatarUrl,
                              height: 50,
                              width: 50,
                            ),
                          ),
                        ],
                      );
                    }

                    return Column(
                      children: [
                        const CircularProgressIndicator(),
                        TextButton(
                          onPressed: () {
                            bloc.closeUser1.add(const None());
                          },
                          child: const Text("Fetch"),
                        )
                      ],
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
