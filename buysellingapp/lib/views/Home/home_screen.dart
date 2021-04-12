import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:untitled/Utils/sharedpref.dart';
import 'package:untitled/WebServices/repository.dart';
import 'package:untitled/res/colors.dart';
import 'package:untitled/res/images.dart';
import 'package:untitled/res/string.dart';
import 'package:untitled/silverstaggeredgridviewandfixedheight.dart';
import 'package:untitled/views/First/first.dart';
import 'package:untitled/views/Notification/notification.dart';
import 'package:untitled/views/detailScreen/detail_screen.dart';
import 'package:untitled/views/filter/filter_screen.dart';
import 'home_contoller.dart';
import 'package:untitled/Utils/my_extensions.dart';
import 'package:untitled/model/Home/Data.dart' as categoryData;
import 'package:untitled/model/Home/GetProduct/Data.dart' as ss;
import 'package:untitled/model/AddProduct/Data.dart' as addProductData;

enum UserType { wishlist, search }

class HomeScreen extends StatefulWidget {
  HomeController homeController;

  HomeScreen({Key key, @required this.homeController}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AfterLayoutMixin<HomeScreen> {
  var selectedWidget = "wishlist";
  UserType _userType = UserType.wishlist;
  var getCartListController;
  int index;
  List<Color> color = [
    Colors.orange,
    Colors.green,
    Colors.amberAccent,
    Colors.blue,
    Colors.blueAccent
  ];
  List<IconData> icon = [
    Icons.camera_alt,
    Icons.camera,
    Icons.accessibility_outlined,
    Icons.home,
    Icons.chat_bubble_outline
  ];

  var _controller = TextEditingController();
  bool showClearButton = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    if (widget.homeController == null) widget.homeController = HomeController();
    widget.homeController.selectedPosition = currentPosition;
    _controller.addListener(() {
      setState(() {
        showClearButton = _controller.text.length > 0;
      });
    });

    if (currentPosition != null) {
      addressFromLatLng(currentPosition.latitude, currentPosition.longitude);
    }

    if (widget.homeController.categoryData.value.isNullOrEmpty() ||
        widget.homeController.categoryData.value.length <= 1) {
      widget.homeController.getCategories();
    }
    widget.homeController.fetchProductsForLocation();
  }

  openPlacePicker() async {
    LocationResult result = await showLocationPicker(context, google_map_key);
    if (result != null) {
      widget.homeController.selectedPosition = Position(
          latitude: result.latLng.latitude, longitude: result.latLng.longitude);
      addressFromLatLng(result.latLng.latitude, result.latLng.longitude);
      widget.homeController.getProduct();
    }
  }

  addressFromLatLng(latitude, longitude) async {
    var addresses = await Geocoder.local
        .findAddressesFromCoordinates(Coordinates(latitude, longitude));
    var first = addresses.first;
    widget.homeController.selectedAddress.value = first.addressLine;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _headerWidget,
                20.toVerticalSpace(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Categories',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                8.toVerticalSpace(),
                Container(
                  height: 140,
                  child: Obx(
                    () => _buildCategoryList(
                        haveList: widget.homeController.categoryData
                            .isNotNullOrEmpty()),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, top: 10, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(AppImages.locations)
                          .paddingOnly(right: 5),
                      Expanded(
                        child: Obx(
                          () => Text(
                            widget.homeController.selectedAddress.value,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                      Text(
                        'Edit',
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold),
                      ).paddingOnly(left: 8, top: 8, bottom: 8).addInkwell(
                          onClick: () {
                        openPlacePicker();
                      })
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, top: 12),
                  child: Text(
                    'Fresh Recommendations',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                12.toVerticalSpace(),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Obx(() => _buildGridView(
                        widget.homeController.recommendationsList
                            .isNotNullOrEmpty(),
                      )),
                ),
                12.toVerticalSpace(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ListView _buildCategoryList({bool haveList}) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        cacheExtent: 99999,
        physics: BouncingScrollPhysics(),
        itemCount: haveList ? widget.homeController.categoryData.length : 5,
        itemBuilder: (context, index) {
          return haveList
              ? _categoryListItem(
                  position: index,
                  categoryData: widget.homeController.categoryData[index])
              : _categoryLoadingWidget;
        });
  }

  Widget _categoryListItem(
      {@required int position, categoryData.Data categoryData}) {
    return InkWell(
      onTap: () {
        print("categoryId");
        widget.homeController.selectedCategory.value = position;
        widget.homeController.requestFilter.categoryId = categoryData.id ?? "";
        widget.homeController.requestFilter.distance = "50";
        widget.homeController.requestFilter.minPrice = "0";
        widget.homeController.requestFilter.maxPrice = "500000";
        widget.homeController.getProduct();
      },
      child: Tooltip(
        message: categoryData.categoryname,
        child: Obx(
          () => Card(
            margin: EdgeInsets.only(
                top: 8,
                bottom: 9,
                right:
                    (position == widget.homeController.categoryData.length - 1)
                        ? 20
                        : 16,
                left: (position == 0) ? 20 : 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            elevation: widget.homeController.selectedCategory.value == position
                ? 4.0
                : 0.0,
            clipBehavior: Clip.antiAlias,
            shadowColor: Colors.black.withOpacity(0.6),
            color: Colors.transparent,
            child: AnimatedContainer(
              width: MediaQuery.of(context).size.width * 0.23,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              duration: Duration(milliseconds: 500),
              decoration: BoxDecoration(
                color: widget.homeController.selectedCategory.value == position
                    ? Color(0XFFFB596D)
                    : Colors.transparent,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: (categoryData.imageType == "all")
                        ? Icon(
                            Icons.dashboard,
                            color: primaryColor,
                          )
                        : (categoryData?.image ?? "").isNotEmpty
                            ? Image.network(
                                Repository.cat_imageUrl + categoryData.image,
                                fit: BoxFit.fill,
                              )
                            : SizedBox.expand(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: AnimatedDefaultTextStyle(
                      style: TextStyle(
                        color: widget.homeController.selectedCategory.value ==
                                position
                            ? Colors.white
                            : Colors.black,
                      ),
                      duration: const Duration(milliseconds: 500),
                      child: Text(
                        categoryData.categoryname,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildGridView(bool haveList) {
    return haveList
        ? GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            cacheExtent: 99999,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                    crossAxisCount: 2, height: 220, mainAxisSpacing: 12),
            itemCount:
                haveList ? widget.homeController.recommendationsList.length : 4,
            itemBuilder: (context, index) {
              return haveList
                  ? GestureDetector(
                      onTap: () {
                        Get.to(DetailScreen(
                          wantChat: true,
                          data: addProductData.ProductData.fromJson(
                            widget.homeController.recommendationsList[index]
                                .toJson(),
                          ),
                        )).then((result) {
                          if (result != null && result == "report_success") {
                            widget.homeController.getProduct();
                          }
                        });
                      },
                      child: _recommendationsListItem(index),
                    )
                  : _recommendationLoadingWidget;
            },
          )
        : Container(
            height: 150, child: Center(child: Text('No items in list')));
  }

  Widget _recommendationsListItem(int index) {
    return Stack(
      children: [
        Positioned.fill(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Card(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 2),
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                  ),
                  elevation: 0,
                  color: Colors.black12.withOpacity(0.2),
                  child: (widget.homeController?.recommendationsList[index]
                                  ?.images ??
                              [])
                          .isNotNullOrEmpty()
                      ? Image.network(
                          Repository.imageUrl +
                                  widget
                                      .homeController
                                      ?.recommendationsList[index]
                                      ?.images[0]
                                      ?.image ??
                              "",
                          fit: BoxFit.cover,
                          width: double.maxFinite,
                          height: double.maxFinite,
                        )
                      : Container(
                          width: double.maxFinite,
                          height: double.maxFinite,
                          color: Colors.black12,
                        ),
                ),
              ),
              12.toVerticalSpace(),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "\$ ${widget.homeController?.recommendationsList[index]?.price ?? ""}",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              2.toVerticalSpace(),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  widget.homeController?.recommendationsList[index]?.title ??
                      "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 16,
          top: -8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                color: Color(0XFFFB596D),
                child: Container(
                  width: 24,
                  height: 36,
                  padding: EdgeInsets.only(bottom: 4),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: widget.homeController.isWishItem(index)
                        ? Icon(Icons.favorite, size: 16, color: Colors.white)
                        : Icon(Icons.favorite_border,
                            size: 16, color: Colors.white),
                  ),
                ).addInkwell(onClick: () {
                  if (widget.homeController.isWishItem(index)) {
                    widget.homeController.deleteCartItem(index,
                        widget.homeController.recommendationsList[index].id);
                  } else {
                    widget.homeController.addToWishList(
                        index,
                        SharedPref.getInstance().getUserId(),
                        widget.homeController.recommendationsList[index].id);
                  }
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget get _categoryLoadingWidget => Shimmer.fromColors(
        // Wrap your widget into Shimmer.
        baseColor: Colors.grey[200],
        highlightColor: Colors.grey[350],
        child: Container(
          margin: EdgeInsets.only(right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
              ),
              8.toVerticalSpace(),
              Container(
                width: 50,
                height: 12,
                decoration: BoxDecoration(color: Colors.grey),
              ),
            ],
          ),
        ),
      );

  Widget get _recommendationLoadingWidget => Shimmer.fromColors(
        // Wrap your widget into Shimmer.
        baseColor: Colors.grey[200],
        highlightColor: Colors.grey[350],
        child: Container(
          height: 220,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Card(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 2),
                  clipBehavior: Clip.antiAlias,
                  elevation: 0,
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                  ),
                  child: Container(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    color: grey,
                  ),
                ),
              ),
              12.toVerticalSpace(),
              Container(
                margin: const EdgeInsets.only(left: 10),
                width: 60,
                height: 12,
                decoration: BoxDecoration(color: Colors.grey),
              ),
              2.toVerticalSpace(),
              Container(
                margin: const EdgeInsets.only(left: 10),
                width: 100,
                height: 12,
                decoration: BoxDecoration(color: Colors.grey),
              ),
            ],
          ),
        ),
      );

  Stack get _headerWidget {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(top: 0, left: 20, right: 12),
          height: 85,
          width: double.maxFinite,
          color: primaryColor,
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leadingWidth: 24,
            leading: Center(
              child: Text(
                "Hi, ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800),
              ),
            ),
            title: Text(
              SharedPref.instancee.getUserName(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            titleSpacing: 0,
            actions: [
              InkWell(
                onTap: () {
                  Get.to(NotificationScreen());
                },
                child: Container(
                  width: 32,
                  height: 32,
                  padding: EdgeInsets.all(7),
                  child: SvgPicture.asset(AppImages.ic_notification_bell,
                      color: Colors.white),
                ),
              ),
              4.toHorizontalSpace(),
              InkWell(
                onTap: () {
                  Get.to(FilterScreen(
                    widget.homeController,
                    widget.homeController.categoryData.value,
                    widget.homeController.tapped.value,
                  )).then((result) {
                    if (result != null && result == "applied") {
                      widget.homeController.getProduct();
                    }
                  });
                },
                child: Container(
                  width: 32,
                  height: 32,
                  padding: EdgeInsets.all(6),
                  child: SvgPicture.asset(AppImages.ic_filter),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 50,
          margin: EdgeInsets.only(left: 20, right: 20, top: 60),
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset(2.0, 2.0),
                blurRadius: 2.0,
                spreadRadius: 2.0,
              ),
            ],
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Icon(Icons.search),
              ),
              Container(
                height: 20,
                child: VerticalDivider(
                  color: Colors.grey,
                  width: 30,
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 1),
                  height: 50,
                  width: double.maxFinite,
                  child: TextField(
                    controller: _controller,
                    onChanged: (String text) {
                      List<ss.Data> temp = [];
                      if (text.isNotEmpty) {
                        print(
                            "search ${widget.homeController.searchList.length} ");
                        for (int i = 0;
                            i < widget.homeController.searchList.length;
                            i++) {
                          print(
                              "search ${widget.homeController.searchList.length} $text${widget.homeController.searchList[i].title}");
                          if (widget.homeController.searchList[i].title
                              .toLowerCase()
                              .startsWith(text.toLowerCase())) {
                            temp.add(widget.homeController.searchList[i]);
                          }
                        }
                        widget.homeController.setProducts(temp);
                        setState(() {});
                      } else {
                        widget.homeController.showAllProducts();
                        setState(() {});
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Search',
                      border: InputBorder.none,
                      suffixIcon: getClearButton(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget get _createCustomTabBar1 {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      width: double.maxFinite,
      height: 45,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: primaryColor, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: LayoutBuilder(
        builder: (context, constraint) {
          return Stack(
            children: [
              StreamBuilder<int>(
                  initialData: 0,
                  stream: widget.homeController.selectedTab.stream,
                  builder: (context, snapshot) {
                    return AnimatedPositioned(
                      duration: Duration(milliseconds: 300),
                      left: (snapshot.data * (constraint.maxWidth / 2)),
                      bottom: 0,
                      top: 0,
                      child: Container(
                        width: constraint.maxWidth / 2,
                        height: double.maxFinite,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    );
                  }),
              Positioned.fill(
                child: Row(
                  children: [
                    _createTab(0, "Wishlist Items"),
                    _createTab(1, "Search Free"),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _createTab(int index, String tabLabel) {
    return StreamBuilder<int>(
        initialData: 0,
        stream: widget.homeController.selectedTab.stream,
        builder: (context, snapshot) {
          return Expanded(
            child: SizedBox.expand(
              child: InkWell(
                onTap: () {
                  _handleTabClick(index);
                },
                child: Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  child: Center(
                    child: AnimatedDefaultTextStyle(
                      duration: Duration(milliseconds: 300),
                      style: (snapshot.data == index)
                          ? TextStyle(color: Colors.white, fontSize: 12)
                          : TextStyle(color: Colors.black, fontSize: 12),
                      child: Text(
                        tabLabel,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  _handleTabClick(int index) {
    widget.homeController.selectedTab.subject.add(index);
    // _pageController.animateToPage(index,
    //     duration: Duration(milliseconds: 450), curve: Curves.easeIn);
  }

  Container buildFlexiblewishList(text) {
    return Container(
      padding: EdgeInsets.only(left: 50),
      child: GestureDetector(
        onTap: () {
          selectedWidget = "1";
          if (_userType == UserType.search) {
            setState(() {
              _userType = UserType.wishlist;
              selectedWidget = "wishlist";
            });
          }
        },
        child: Container(
            width: Get.width * 0.4,
            height: Get.height * 0.06,
            decoration: BoxDecoration(
                color: (_userType == UserType.wishlist)
                    ? primaryColor
                    : Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(width: 2, color: primaryColor)),
            child: Center(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: GoogleFonts.sourceSansPro(
                  color: (_userType == UserType.wishlist)
                      ? Colors.white
                      : labeltextColor,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )),
      ),
    );
  }

  Container buildFlexibleSearch(text) {
    return Container(
      child: GestureDetector(
        onTap: () {
          if (_userType == UserType.wishlist) {
            setState(() {
              _userType = UserType.search;
              selectedWidget = "search";
            });
          } else {
            return;
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 180),
          child: Container(
            width: Get.width * 0.4,
            height: Get.height * 0.06,
            decoration: BoxDecoration(
                color: (_userType == UserType.search)
                    ? primaryColor
                    : Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(width: 2, color: primaryColor)),
            child: Center(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: (_userType == UserType.search)
                      ? Colors.white
                      : labeltextColor,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getClearButton() {
    if (!showClearButton) {
      return null;
    }
    return IconButton(
      onPressed: () {
        _controller.clear();
        widget.homeController.getProduct();
      },
      icon: Icon(Icons.clear, size: 20, color: Colors.grey),
    );
  }
}
