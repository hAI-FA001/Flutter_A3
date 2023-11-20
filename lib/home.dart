import 'package:assignment3/model/league.dart';
import 'package:assignment3/model/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'league_cards.dart';

class Common {
  static String baseUrl = 'https://fls.contentprotectforce.com/public/';
  static String apiEndPoint = 'api/leagues';
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<List<League>> _fetchLeagues() async {
    http.Response r =
        await http.get(Uri.parse('${Common.baseUrl}${Common.apiEndPoint}'));

    if (r.statusCode == 200) {
      return Model.fromJson(r.body).league!;
    } else {
      throw Exception('Failed to fetch league data\nPlease try again later');
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Row(
            children: [
              Text('Flutter Leagues'),
              SizedBox(
                width: 10,
              ),
              Icon(Icons.sports_soccer, size: 22),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(items: const [
          BottomNavigationBarItem(icon: Icon(Icons.sports_soccer), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.scoreboard), label: ''),
        ]),
        drawer: Drawer(
            child: Column(
          children: [
            UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Color.fromARGB(255, 6, 3, 70)),
                accountName: Text(
                  'Flutter',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: const Color.fromARGB(255, 135, 141, 159),
                        fontSize: 30,
                      ),
                ),
                accountEmail: Text(
                  'Leagues',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: const Color.fromARGB(255, 135, 141, 159),
                        fontSize: 30,
                      ),
                )),
            for (int i = 0; i < 5; i++)
              ListTile(
                leading: const Icon(
                  Icons.sports_score,
                  size: 50,
                  color: Color.fromARGB(255, 221, 233, 197),
                ),
                subtitle: Text(
                  'Total Score: ${(i + 1) * 10}',
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: const Color.fromARGB(255, 135, 141, 159)),
                ),
                title: Text(
                  'Team-${i + 1}',
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: const Color.fromARGB(255, 201, 210, 237)),
                ),
              )
          ],
        )),
        body: FutureBuilder<List<League>>(
            future: _fetchLeagues(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return LeagueView(leaguesData: snapshot.data!);
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}',
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: Colors.red)),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      );
}

class LeagueView extends StatelessWidget {
  const LeagueView({super.key, required this.leaguesData});
  final List<League> leaguesData;

  @override
  Widget build(BuildContext context) => Container(
          child: GridView.count(
        crossAxisCount: 3,
        children: [
          for (int i = 0; i < leaguesData.length; i++)
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 60.0, horizontal: 20.0),
              child: GridTile(
                  footer: Padding(
                    padding: const EdgeInsets.only(left: 80.0, bottom: 10.0),
                    child: Text(leaguesData[i].name!,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                                color: Color.fromARGB(255, 255, 246, 190))),
                  ),
                  child: GestureDetector(
                      child: LeagueCard(league: leaguesData[i]),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return LeagueDetail(leagueId: leaguesData[i].id!);
                          },
                        ));
                      })),
            )
        ],
      ));
}
