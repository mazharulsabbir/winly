import 'package:flutter/material.dart';
import 'package:winly/globals/controllers/auth_controller.dart';
import 'package:winly/helpers/snack.dart';
import 'package:winly/models/tournament/tournament.dart';
import 'package:winly/services/api/tournament_api.dart';
import 'package:winly/widgets/common_leading.dart';

class JoinTournament extends StatefulWidget {
  final Tournament? tournament;
  const JoinTournament({Key? key, this.tournament}) : super(key: key);

  @override
  _JoinTournamentState createState() => _JoinTournamentState();
}

class _JoinTournamentState extends State<JoinTournament> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _inGameNameControllers = [];
  final List<TextEditingController> _playerIdCodeControllers = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    for (final controller in _inGameNameControllers) {
      controller.dispose();
    }
    for (final controller in _playerIdCodeControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget _textFieldBuilder() {
    return ListView.builder(
      itemCount: widget.tournament?.field ?? 0,
      padding: const EdgeInsets.only(top: 16, bottom: 100),
      itemBuilder: (BuildContext context, int index) {
        TextEditingController controller = TextEditingController();
        TextEditingController controller2 = TextEditingController();

        _inGameNameControllers.add(controller);
        _playerIdCodeControllers.add(controller2);

        final textField = TextFormField(
          controller: controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "In Game Name",
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter in game name';
            }
            return null;
          },
        );

        final textField2 = TextFormField(
          controller: controller2,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Player Id Code",
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter player Id Code';
            }
            return null;
          },
        );

        return Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Text(
                'Player ${index + 1} Information',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                child: textField,
                padding: const EdgeInsets.only(bottom: 10),
              ),
              Container(
                child: textField2,
                padding: const EdgeInsets.only(bottom: 10),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join Tournament'),
        leading: const CommonLeading(),
      ),
      body: Form(key: _formKey, child: _textFieldBuilder()),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          _formKey.currentState!.save();
          if (_formKey.currentState!.validate()) {
            _submit();
          }
        },
        label: const Text('Join Tournament'),
      ),
    );
  }

  void _submit() async {
    List<String> _ids =
        _playerIdCodeControllers.map((controller) => controller.text).toList();
    List<String> _inGameNames =
        _inGameNameControllers.map((controller) => controller.text).toList();

    try {
      AuthController _auth = AuthController();
      dynamic _res = await TournamentAPI.joinTournament(
        widget.tournament?.id,
        _inGameNames.join(","),
        _ids.join(","),
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
  }
}
