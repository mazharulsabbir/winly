import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:winly/globals/controllers/tournament_controller.dart';
import 'package:winly/pages/home/widget/tournament_widget.dart';
import 'package:winly/widgets/common_loading_overly.dart';

class Tournaments extends StatelessWidget {
  const Tournaments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TournamentController>(
      init: TournamentController(),
      builder: (controller) => CommonLoadingOverlay(
        loading: controller.isLoading,
        child: Scaffold(
          floatingActionButton: const FloatingActionButton(
            onPressed: null,
            child: Icon(PhosphorIcons.sort_ascending),
          ),
          body: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10).copyWith(bottom: 100),
            itemCount: controller.tournaments?.length,
            itemBuilder: (context, index) => TournamentItemWidget(
              tournament: controller.tournaments?[index],
            ),
          ),
        ),
      ),
    );
  }
}
