part of 'suggestion_page.dart';

class _SuggestionView extends StatelessWidget {
  const _SuggestionView({Key? key}) : super(key: key);

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
              StreamBuilder(
                stream: bloc.users,
                builder: ((context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: AlertDialog(
                        content: Text(snapshot.error.toString()),
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                }),
              ),
              const SizedBox(height: 20),
              SuggestedUser(
                stream: bloc.user1,
                close: bloc.closeUser1,
              ),
              const SizedBox(height: 20),
              SuggestedUser(
                stream: bloc.user2,
                close: bloc.closeUser2,
              ),
              const SizedBox(height: 20),
              SuggestedUser(
                stream: bloc.user3,
                close: bloc.closeUser3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
