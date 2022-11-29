import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ruqe/ruqe.dart';
import 'package:who_to_follow/modules/user/domain/entities/user.dart';
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
      debugShowCheckedModeBanner: false,
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
    bloc.closeUser2.add(const None());
    bloc.closeUser3.add(const None());

    return Scaffold(
      backgroundColor: const Color(0xFF454545),
      body: Center(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 35, 20, 40),
          margin: const EdgeInsets.all(20),
          width: 350,
          decoration: BoxDecoration(
            color: const Color(0xFF555555),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF757474)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Who to follow",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                    ),
                  ),
                  Row(
                    children: [
                      TextButton(
                        style: const ButtonStyle(
                          textStyle: MaterialStatePropertyAll(
                            TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          padding: MaterialStatePropertyAll(
                            EdgeInsets.all(0),
                          ),
                        ),
                        onPressed: () {
                          bloc.refreshedUsers.add(const None());
                        },
                        child: const Text("Refresh"),
                      ),
                      const SizedBox(width: 15),
                      TextButton(
                        style: const ButtonStyle(
                          textStyle: MaterialStatePropertyAll(
                            TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          padding: MaterialStatePropertyAll(
                            EdgeInsets.all(0),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text("View All"),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Flex(
                direction: Axis.horizontal,
                children: [
                  Suggestion(
                    stream: bloc.user1,
                    close: bloc.closeUser1,
                  )
                ],
              ),
              const SizedBox(height: 20),
              Flex(
                direction: Axis.horizontal,
                children: [
                  Suggestion(
                    stream: bloc.user2,
                    close: bloc.closeUser2,
                  )
                ],
              ),
              const SizedBox(height: 20),
              Flex(
                direction: Axis.horizontal,
                children: [
                  Suggestion(
                    stream: bloc.user3,
                    close: bloc.closeUser3,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Suggestion extends StatelessWidget {
  const Suggestion({
    Key? key,
    required this.stream,
    required this.close,
  }) : super(key: key);
  final Stream<User> stream;
  final StreamSink<None<dynamic>> close;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
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
                  height: 60,
                  width: 60,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          snapshot.data!.login.replaceFirst(
                            snapshot.data!.login[0],
                            snapshot.data!.login[0].toUpperCase(),
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "@${snapshot.data!.login}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 6),
                      width: 210,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                Colors.white,
                              ),
                              textStyle: MaterialStatePropertyAll(
                                TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              padding: MaterialStatePropertyAll(
                                EdgeInsets.all(12),
                              ),
                            ),
                            onPressed: () {},
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.person_add,
                                  color: Color(0xFF5CB965),
                                ),
                                SizedBox(width: 7),
                                Text(
                                  "Follow",
                                  style: TextStyle(
                                    color: Color(0xFF5CB965),
                                  ),
                                )
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              close.add(const None());
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Color(0xFF5CB965),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        }

        return Container(
          height: 50,
          width: 280,
          decoration: BoxDecoration(
            color: const Color(0xFF757474),
            borderRadius: BorderRadius.circular(5),
          ),
        );
      },
    );
  }
}
