import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winly/globals/controllers/tournament_controller.dart';
import 'package:winly/pages/home/widget/tournament_widget.dart';
import 'package:winly/widgets/common_leading.dart';
import 'package:winly/widgets/common_loading_overly.dart';

class Tournaments extends StatelessWidget {
  const Tournaments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TournamentController>(
      init: TournamentController(),
      builder: (controller) => CommonLoadingOverlay(
        loading: controller.isLoading,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10),
          itemCount: controller.tournaments?.length,
          itemBuilder: (context, index) => TournamentItemWidget(
            tournament: controller.tournaments?[index],
          ),
        ),
      ),
    );
  }
}
