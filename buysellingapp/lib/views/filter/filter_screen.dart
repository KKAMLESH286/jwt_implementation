import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/Utils/frequent_utils.dart';
import 'package:untitled/model/Home/Data.dart';
import 'package:untitled/model/filterData/filter_data.dart';
import 'package:untitled/res/colors.dart';
import 'package:untitled/res/images.dart';
import 'package:untitled/views/Home/home_contoller.dart';
import 'package:untitled/Utils/my_extensions.dart';

class FilterScreen extends StatefulWidget {
  FilterScreen(
    this.homeController,
    this.categoryData,
    this.tapped,
  );

  HomeController homeController;
  final List<Data> categoryData;
  int tapped;
  int index;

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
//  FilterController filterController = FilterController();
//   bool _validate = false;
  TextEditingController dollarController = TextEditingController();
  TextEditingController dollaroneController = TextEditingController();
  double seekBar = 10.0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FilterData previousFilters = FilterData();
  Data _currentItemSelected = null;

  @override
  void initState() {
    previousFilters = widget.homeController.requestFilter;

    if ((widget.homeController.requestFilter?.categoryId ?? "").isNotEmpty) {
      _currentItemSelected = widget.homeController.categoryData.firstWhere(
          (element) =>
              element.id == widget.homeController.requestFilter.categoryId,
          orElse: () => null);
    }

    if ((previousFilters?.minPrice ?? "").isNotEmpty)
      dollarController.text = (previousFilters.minPrice).toString();
    if ((previousFilters?.maxPrice ?? "").isNotEmpty)
      dollaroneController.text = (previousFilters.maxPrice).toString();
    if ((previousFilters?.distance ?? "").isNotEmpty)
      seekBar = double.parse(previousFilters.distance);
    super.initState();
  }

  _onResetButtonClick() {
    widget.homeController.requestFilter = previousFilters;
    Get.back(result: "applied");
  }

  void _onApplyClick() {
    var min = dollarController.text.toString();
    if(min.isEmpty) min = "0";
    var max = dollaroneController.text.toString();
    if (min.isNotNullOrEmpty() &&
        max.isNotNullOrEmpty() &&
        (int.parse(min) > int.parse(max))) {
      FrequentUtils.getInstance()
          .showMessage("Minimum price should be greater than maximum price");
      return;
    }

    widget.homeController.requestFilter.categoryId =
        _currentItemSelected?.id ?? "";
    widget.homeController.requestFilter.minPrice = min;
    widget.homeController.requestFilter.maxPrice = max;
    widget.homeController.requestFilter.location = "";
    widget.homeController.requestFilter.distance = seekBar.toString();

    Get.back(result: "applied");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xffFFFFFF),
      appBar: AppBar(
        toolbarHeight: 70,
        leadingWidth: 52,
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        leading: Container(
          padding: EdgeInsets.only(left: 20),
          child: SvgPicture.asset(AppImages.arrow).addInkwell(onClick: () {
            Get.back();
          }),
        ),
        //How to use!
//        actions: [
//          Padding(
//            padding: const EdgeInsets.only(top: 5),
//            child: Text(
//              "How to use!",
//              style: GoogleFonts.poppins(
//                decoration: TextDecoration.underline,
//                fontSize: 13,
//              ),
//            ),
//          ),
//          SizedBox(
//            width: 10,
//          ),
//        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
              maxHeight: Get.height - 70 - Get.mediaQuery.viewPadding.top),
          padding: EdgeInsets.only(top: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Color(0xffF2F2F2),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                width: double.maxFinite,
                padding: EdgeInsets.only(left: 10, right: 15),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<Data>(
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: borderColor,
                    ),
                    hint: Text("Select category"),
                    isExpanded: true,
                    items: widget.categoryData.map((dropDownStringItem) {
                      return DropdownMenuItem<Data>(
                        value: dropDownStringItem,
                        child: Text(
                          dropDownStringItem.categoryname,
                          style: GoogleFonts.poppins(
                              color: Color(0xff696969),
                              fontWeight: FontWeight.w400),
                        ),
                      );
                    }).toList(),
                    onChanged: (Data ValueSelected) {
                      _onDropDownItemSelected(ValueSelected);
                    },
                    value: _currentItemSelected,
                  ),
                ),
              ).addOnlyPadding(left: 20, right: 20, top: 20),
              Text(
                'Categorized listing have more visibility',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    color: textColor,
                  ),
                ),
              ).addOnlyPadding(left: 20, top: 5),
              Text(
                'Price:',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15.0,
                    color: textColor,
                  ),
                ),
              ).addOnlyPadding(
                left: 20,
                top: 15,
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    height: 40,
                    decoration: BoxDecoration(
                        color: Color(0xffF2F2F2),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    width: Get.width * 0.42,
                    child: TextField(
                      controller: dollarController,
                      decoration: InputDecoration(
                        border:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                        hintText: "From \$",
                        contentPadding: EdgeInsets.only(left: 12, bottom: 5),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      right: 14,
                    ),
                    height: 40,
                    decoration: BoxDecoration(
                        color: Color(0xffF2F2F2),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    width: Get.width * 0.43,
                    child: TextField(
                      controller: dollaroneController,
                      decoration: InputDecoration(
                        border:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                        hintText: "To \$",
                        contentPadding: EdgeInsets.only(left: 12, bottom: 5),
                      ),
                    ),
                  ),
                ],
              ),

              Text(
                'Set a competitive price',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    color: textColor,
                  ),
                ),
              ).addOnlyPadding(left: 20, top: 10),
              // Container(
              //   decoration: BoxDecoration(
              //       color: Color(0xffF2F2F2),
              //       borderRadius: BorderRadius.all(Radius.circular(5))),
              //   width: double.maxFinite,
              //   padding: EdgeInsets.only(left: 10, right: 15),
              //   child: DropdownButtonHideUnderline(
              //     child: DropdownButton<String>(
              //       hint: Text(
              //         'Category',
              //         style: TextStyle(color: Colors.black),
              //       ),
              //       icon: Icon(Icons.keyboard_arrow_down),
              //       isExpanded: true,
              //       items: _brandone.map((String dropDownStringItem) {
              //         return DropdownMenuItem<String>(
              //           value: dropDownStringItem,
              //           child: Text(
              //             dropDownStringItem,
              //             style: GoogleFonts.poppins(
              //                 color: Color(0xff696969),
              //                 fontWeight: FontWeight.w400),
              //           ),
              //         );
              //       }).toList(),
              //       onChanged: (String ValueSelected) {
              //         _onDropDownItemSelectedone(ValueSelected);
              //       },
              //       value: _currentItemSelectedone,
              //     ),
              //   ),
              // ).addOnlyPadding(left: 20, right: 15, top: 20),
              // Text(
              //   'Where is listing located',
              //   style: GoogleFonts.poppins(
              //     textStyle: TextStyle(
              //       fontWeight: FontWeight.w400,
              //       fontSize: 10,
              //       color: textColor,
              //     ),
              //   ),
              // ).addOnlyPadding(left: 20, top: 10),
              Text(
                'Distance',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.0,
                    color: textColor,
                  ),
                ),
              ).addOnlyPadding(left: 20, top: 15),
              Container(
                width: double.maxFinite,
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: _distanceSlider,
              ),
//              Text(
//                'Sort By:',
//                style: GoogleFonts.poppins(
//                  textStyle: TextStyle(
//                    fontWeight: FontWeight.w400,
//                    fontSize: 17,
//                    color: textColor,
//                  ),
//                ),
//              ).addOnlyPadding(left: 20, top: 15, bottom: 10),
              // Obx(
              //   () => Container(
              //     height: 130,
              //     child: GridView.builder(
              //       physics: NeverScrollableScrollPhysics(),
              //       padding: EdgeInsets.only(
              //         top: 10,
              //       ),
              //       shrinkWrap: true,
              //       itemCount: filterController.data.length,
              //       gridDelegate:
              //           SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
              //         crossAxisCount: 3,
              //         crossAxisSpacing: 10,
              //         mainAxisSpacing: 14,
              //         height: 48.0, //48 dp of height
              //       ),
              //       itemBuilder: (context, index) {
              //         // final item = ;
              //         return GestureDetector(
              //           onTap: () {
              //             // [selectedIndex] = false;
              //             // selectedDateIndex = index;
              //             // dayDate[index].isSelected = true;
              //             setState(() {
              //               tapped = index;
              //             });
              //             // selectedIndex = index;
              //           },
              //           child: Container(
              //               width: Get.width * 0.3,
              //               height: Get.height * 0.06,
              //               // margin: EdgeInsets.all(10.0),
              //               // padding: EdgeInsets.all(10.0),
              //               decoration: BoxDecoration(
              //                 color:
              //                     tapped == index ? primaryColor : Colors.white,
              //                 borderRadius: BorderRadius.circular(25.0),
              //                 border: Border.all(color: borderColor),
              //               ),
              //               child: Center(
              //                 child: Text(
              //                   filterController.data[index].subcategoryname ??
              //                       "",
              //                   textAlign: TextAlign.center,
              //                   style: TextStyle(
              //                     color: tapped == index
              //                         ? Colors.white
              //                         : Colors.grey,
              //                     fontSize: 16.0,
              //                   ),
              //                 ),
              //               )),
              //         );
              //       },
              //     ),
              //   ).addOnlyPadding(left: 13, right: 15),
              // ),
              Spacer(),
              Row(
                children: [
                  // Container(
                  //   // margin: EdgeInsets.only(left: 50, right: 50, top: 5),
                  //   width: Get.width * 0.5,
                  //   height: 60,
                  //   decoration: BoxDecoration(
                  //       border: Border.all(width: 2, color: primaryColor)),
                  //   child: MaterialButton(
                  //     shape: RoundedRectangleBorder(),
                  //     onPressed: _onResetButtonClick,
                  //     color: Colors.white,
                  //     child: Center(
                  //       child: Text(
                  //         'Reset',
                  //         style: GoogleFonts.sourceSansPro(
                  //           textStyle: TextStyle(
                  //             fontWeight: FontWeight.w600,
                  //             fontSize: 18,
                  //             color: primaryColor,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Container(
                    // margin: EdgeInsets.only(left: 50, right: 50, top: 5),
                    width: Get.width,
                    height: 60,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(),
                      onPressed: _onApplyClick,
                      color: primaryColor,
                      child: Center(
                        child: Text(
                          'Apply',
                          style: GoogleFonts.sourceSansPro(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  FlutterSlider get _distanceSlider {
    return FlutterSlider(
      values: [seekBar],
      min: 10.0,
      max: 50.0,
      handlerWidth: 24,
      handlerHeight: 24,
      rangeSlider: false,
      jump: false,
      // hatchMark: FlutterSliderHatchMark(labels: [
      //   FlutterSliderHatchMarkLabel(
      //     percent: 0,
      //     label: Text("10 miles"),
      //   ),
      //   FlutterSliderHatchMarkLabel(
      //     percent: 100,
      //     label: Text("50 miles"),
      //   ),
      // ]),
      tooltip: FlutterSliderTooltip(
        alwaysShowTooltip: true,
        direction: FlutterSliderTooltipDirection.top,
        positionOffset: FlutterSliderTooltipPositionOffset(top: -12),
        custom: (value) {
          seekBar = value;
          return Text("${value.toInt()} miles");
        },
      ),
      handler: FlutterSliderHandler(
        decoration: BoxDecoration(),
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: primaryColor,
            shape: BoxShape.circle,
          ),
        ),
      ),
      rightHandler: FlutterSliderHandler(
        decoration: BoxDecoration(),
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: primaryColor,
            shape: BoxShape.circle,
          ),
        ),
      ),
      trackBar: FlutterSliderTrackBar(
        activeTrackBarHeight: 6,
        inactiveTrackBarHeight: 6,
        inactiveTrackBar: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black12,
        ),
        activeTrackBar: BoxDecoration(
            borderRadius: BorderRadius.circular(4), color: primaryColor),
      ),
    );
  }

  Widget textField(
    TextEditingController controller,
    String text,
  ) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xffF2F2F2),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      width: Get.width * 0.43,
      child: new TextFormField(
        autofocus: false,
        controller: controller,
        style: GoogleFonts.poppins(
            color: Color(0xff696969), fontWeight: FontWeight.w400),
        obscureText: false,
        autocorrect: false,
        decoration: new InputDecoration(
          hintText: text,
          hintStyle: GoogleFonts.poppins(
              color: Color(0xff696969), fontWeight: FontWeight.w400),
          border: UnderlineInputBorder(borderSide: BorderSide.none),
          contentPadding: EdgeInsets.all(12),
          // labelText: text,
          // labelStyle:
          //     GoogleFonts.poppins(color: labeltextColor, fontSize: 14.0),
        ),
      ),
    ).addOnlyPadding(
      left: 20,
    );
  }

  void _onDropDownItemSelected(Data newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

// void _onDropDownItemSelectedone(String newValueSelected) {
//   setState(() {
//     this._currentItemSelectedone = newValueSelected;
//   });
// }
}

class Electronics {
  Electronics(this.name);

  String name;
}

class SeekbarText {
  SeekbarText(
    this.name,
  );

  String name;
}
