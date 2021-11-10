import 'package:flutter/material.dart';
import 'package:winly/pages/tournament/widget/tournament_info.dart';
import 'package:winly/widgets/common_loading_overly.dart';

class TournamentDetail extends StatelessWidget {
  final dynamic tournament;
  const TournamentDetail({Key? key, this.tournament}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonLoadingOverlay(
      loading: false,
      child: Scaffold(
        body: DefaultTabController(
          length: 3,
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
                  title: const Text('Tournament Name'),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            "https://images.firstpost.com/fpimages/1200x800/fixed/jpg/2019/01/PUBG-Lite-copy.jpg",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: const TournamentInfoWidget(),
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  delegate: _SliverAppBarDelegate(
                    const TabBar(
                      indicatorSize: TabBarIndicatorSize.label,
                      unselectedLabelColor: Colors.teal,
                      indicatorColor: Colors.amber,
                      labelColor: Colors.amber,
                      tabs: [
                        Tab(text: "About"),
                        Tab(text: "Rules"),
                        Tab(text: "Point System"),
                      ],
                    ),
                  ),
                  pinned: true,
                ),
              ];
            },
            body: const TabBarView(children: [
              Center(
                child: Text('About'),
              ),
              Center(
                child: Text('Rules'),
              ),
              Center(
                child: Text('Point System'),
              )
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
