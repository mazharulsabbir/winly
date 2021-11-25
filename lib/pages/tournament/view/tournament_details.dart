import 'package:flutter/material.dart';
import 'package:winly/models/tournament/tournament.dart';
import 'package:winly/pages/tournament/widget/tournament_info.dart';
import 'package:winly/pages/tournament/widget/tournament_joined_players.dart';
import 'package:winly/widgets/common_loading_overly.dart';

class TournamentDetail extends StatelessWidget {
  final Tournament? tournament;
  const TournamentDetail({Key? key, this.tournament}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonLoadingOverlay(
      loading: false,
      child: Scaffold(
        body: DefaultTabController(
          length: tournament?.joinStatus == true ? 4 : 3,
          child: NestedScrollView(
            headerSliverBuilder: (
              BuildContext context,
              bool innerBoxIsScrolled,
            ) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 350.0,
                  floating: true,
                  pinned: true,
                  snap: true,
                  elevation: 0,
                  title: Text('${tournament?.title}'),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: Image.network(
                            "${tournament?.bannerImg}",
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                "assets/icon/icon_transparent.png",
                              );
                            },
                          ).image,
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: TournamentInfoWidget(
                        tournament: tournament,
                        isTournamentDetails: true,
                      ),
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  delegate: _SliverAppBarDelegate(
                    TabBar(
                      indicatorSize: TabBarIndicatorSize.label,
                      unselectedLabelColor: Colors.teal,
                      indicatorColor: Colors.amber,
                      labelColor: Colors.amber,
                      isScrollable: true,
                      tabs: [
                        const Tab(text: "About"),
                        const Tab(text: "Rules"),
                        const Tab(text: "Point System"),
                        if (tournament?.joinStatus == true)
                          const Tab(text: "Players"),
                      ],
                    ),
                  ),
                  pinned: true,
                ),
              ];
            },
            body: TabBarView(children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '${tournament?.description}',
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '${tournament?.rules}',
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '${tournament?.points}',
                  textAlign: TextAlign.justify,
                ),
              ),
              if (tournament?.joinStatus == true) TournamentJoinedPlayers()
            ]),
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(child: _tabBar);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
