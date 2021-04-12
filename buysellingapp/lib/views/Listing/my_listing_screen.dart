import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:untitled/res/colors.dart';
import 'package:untitled/views/Listing/sold/sold_list.dart';
import 'getXController/my_listing_controller.dart';
import 'tabScreens/list_expired.dart';
import 'tabScreens/selling_tab_screen.dart';
import 'tabScreens/wishlist_tab_screen.dart';

class MyListingScreen extends StatefulWidget {
  @override
  _MyListingScreenState createState() => _MyListingScreenState();
}

class _MyListingScreenState extends State<MyListingScreen>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<MyListingScreen> {
  TabController _tabController;
  final GetMyListingController _controller = GetMyListingController();
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(initialIndex: 0, length: 4, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        print(
            "_tabController: tab change completed index: ${_tabController.index}");
        switch (_tabController.index) {
          case 0:

            ///_controller.getSellingListing();
            /// No need to hit this api here.
            /// will hit inside selling tab screen
            break;
          case 1:
            _controller.getExpiredListing();
            break;
          case 2:
            _controller.getSoldListing();
            break;
          case 3:
            _controller.getWishItem();
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  getTab_bar() {
    return TabBar(
      labelColor: Colors.white,
      indicatorColor: Colors.white,
      unselectedLabelColor: Colors.white54,
      indicatorWeight: 3.0,
      tabs: <Tab>[
        Tab(
          text: null,
          child: Text(
            "Selling",
            style: TextStyle(fontSize: 11),
          ),
        ),
        Tab(
          text: null,
          child: Text(
            "Expired",
            style: TextStyle(fontSize: 11),
          ),
        ),
        Tab(
          text: null,
          child: Text(
            "Sold",
            style: TextStyle(fontSize: 11),
          ),
        ),
        Tab(
          text: null,
          child: Text(
            "Wish Items",
            style: TextStyle(fontSize: 11),
          ),
        ),
      ],
      controller: _tabController,
    );
  }

  gettab_barview(var tabs) {
    return TabBarView(
      children: tabs,
      controller: _tabController,
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Listing',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
        bottom: getTab_bar(),
        actions: [
          // Padding(
          //   padding: const EdgeInsets.only(right: 15.0),
          //   child: Icon(
          //     Icons.share,
          //     color: Colors.white,
          //   ),
          // )
        ],
      ),
      body: gettab_barview(<Widget>[
        SellingTabScreen(controller: _controller),
        ExpiredTabScreen(controller: _controller),
        SoldTabScreen(controller: _controller),
        WishListTabScreen(controller: _controller)
      ]),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
