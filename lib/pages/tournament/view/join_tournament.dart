import 'package:flutter/material.dart';
import 'package:winly/globals/controllers/auth_controller.dart';
import 'package:winly/helpers/snack.dart';
import 'package:winly/models/tournament.dart';
import 'package:winly/services/api/tournament_api.dart';
import 'package:winly/widgets/common_leading.dart';

class JoinTournament extends StatefulWidget {
  final Tournament? tournament;
  const JoinTournament({Key? key, this.tournament}) : super(key: key);

  @override
  _JoinTournamentState createState() => _JoinTournamentState();
}

class _JoinTournamentState extends State<JoinTournament> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join Tournament'),
        leading: const CommonLeading(),
      ),
      body: Center(
        child: Text('Join Tournament'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // todo: join on tournament
          try {
            AuthController _auth = AuthController();
            dynamic _res = await TournamentAPI.joinTournament(
              widget.tournament?.id,
              widget.tournament?.gameName,
              _auth.token,
            );

            snack(
              title: 'Message',
              desc: "${_res.data['return_msg']}",
              icon: const Icon(Icons.done),
            );
          } catch (e) {
            debugPrint(e.toString());
          }
        },
        label: const Text('Join Tournament'),
      ),
    );
  }
}
