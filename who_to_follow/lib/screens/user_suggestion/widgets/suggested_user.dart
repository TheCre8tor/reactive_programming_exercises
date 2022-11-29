import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ruqe/ruqe.dart';
import 'package:who_to_follow/modules/user/domain/entities/user.dart';

class SuggestedUser extends StatelessWidget {
  const SuggestedUser({
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
