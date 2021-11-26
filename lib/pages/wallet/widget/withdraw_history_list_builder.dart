import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:winly/models/withdraws.dart';
import 'package:winly/widgets/empty_list.dart';

class WithdrawHistoryListBuilder extends StatelessWidget {
  final List<Withdraw>? withdraws;
  const WithdrawHistoryListBuilder({Key? key, this.withdraws})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (withdraws == null || withdraws!.isEmpty)
        ? const CommonEmptyScreenWidget()
        : ListView.builder(
            itemBuilder: (_, index) {
              return ListTile(
                title: Text(
                  'Cash out',
                  style: Theme.of(context).textTheme.subtitle2!.merge(
                        const TextStyle(fontSize: 17),
                      ),
                ),
                subtitle: Text(withdraws![index].createdAt.toString()),
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(PhosphorIcons.share),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      withdraws![index].amount ?? '0',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Dhaka',
                      style: Theme.of(context).textTheme.subtitle1,
                    )
                  ],
                ),
              );
            },
            itemCount: withdraws!.length,
            shrinkWrap: true,
          );
  }
}
