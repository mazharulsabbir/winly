import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:winly/models/settings.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settigs'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: ListView.separated(
            separatorBuilder: (_, i) => const Divider(),
            itemBuilder: (_, index) {
              return ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: SettingsModel.settings[index].leadingBackC,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Icon(
                    SettingsModel.settings[index].iconData,
                    color: Theme.of(context).primaryIconTheme.color,
                  ),
                ),
                title: Text(SettingsModel.settings[index].title),
                trailing: const Icon(Icons.arrow_right_outlined),
              );
            },
            itemCount: SettingsModel.settings.length,
            shrinkWrap: true,
          ),
        ),
      ),
    );
  }
}
