import 'package:assignment3/home.dart';
import 'package:assignment3/model/league.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LeagueCard extends StatelessWidget {
  const LeagueCard({super.key, required this.league});

  final League league;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [
          Color.fromARGB(255, 49, 6, 79),
          Color.fromARGB(255, 82, 19, 38)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        border: Border.all(style: BorderStyle.solid, color: Colors.red),
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          alignment: Alignment.center,
          image: NetworkImage(
            '${Common.baseUrl}${league.icon}',
          ),
          fit: BoxFit.fill,
          colorFilter: const ColorFilter.mode(
            Color.fromARGB(255, 165, 157, 131),
            BlendMode.softLight,
          ),
        ),
      ),
    );
  }
}

class LeagueDetail extends StatelessWidget {
  const LeagueDetail({super.key, required this.leagueId});
  final int leagueId;

  Future<League> _fetchLeague(int leagueId) async {
    http.Response r = await http
        .get(Uri.parse('${Common.baseUrl}${Common.apiEndPoint}/${leagueId}'));
    if (r.statusCode == 200) {
      return League.fromJson(r.body);
    } else {
      throw Exception(
          'Failed to fetch league with id $leagueId\nTry again later');
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: _fetchLeague(leagueId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return LeagueDetailPage(league: snapshot.data!);
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Colors.red)),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }));
}

class LeagueDetailPage extends StatelessWidget {
  const LeagueDetailPage({super.key, required this.league});

  final League league;

  @override
  Widget build(BuildContext context) =>
      Container(child: Center(child: Text(league.name!)));
}
