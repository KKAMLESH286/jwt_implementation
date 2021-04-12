import 'dart:io';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/Utils/frequent_utils.dart';
import 'package:untitled/WebServices/repository.dart';
import 'package:untitled/model/conditions/ConditionData.dart';
import 'package:untitled/model/selling/Data.dart';
import 'package:untitled/res/colors.dart';
import 'package:untitled/Utils/my_extensions.dart';
import 'package:untitled/res/images.dart';
import 'package:untitled/res/string.dart';
import 'package:untitled/views/First/first.dart';
import 'package:untitled/views/Selling/selling_controller.dart';
import 'getXController/AddThreeController.dart';

enum UserType { donor, recipient }

class AddThree extends StatefulWidget {
  AddThree({
    @required this.sellingController,
    @required this.data,
    @required this.tapped,
    @required this.categoryId,
    @required this.index,
  });
  final List<Data> data;
  final int tapped;
  final int index;
  final String categoryId;
  final SellingController sellingController;

  @override
  _AddThreeState createState() => _AddThreeState();
}

class _AddThreeState extends State<AddThree> {
  final AddThreeController _controller = AddThreeController();
  final TextEditingController titleController = TextEditingController();
  final FocusNode titleFN = FocusNode();

  // final TextEditingController locationController = TextEditingController();
  // final FocusNode locationFN = FocusNode();

  int tapped;
  var selectedcatid = 0;
  var _currentItemSelected = "";

  final picker = ImagePicker();
  File file;
  Position selectedPosition;

  Widget get conditionsDropdown => Container(
        decoration: BoxDecoration(
            color: Color(0xffF2F2F2),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        width: double.maxFinite,
        padding: EdgeInsets.only(left: 10, right: 15),
        child: Obx(
          () => DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: borderColor,
              ),
              isExpanded: true,
              hint: const Text("Condition"),
              items: widget.sellingController.conditions.value
                  .map((ConditionData data) {
                return DropdownMenuItem<String>(
                  value: data.id,
                  child: Row(
                    children: [
                      Image.network(
                        Repository.condition_imageUrl + data.image, 
                        height: 20,
                        width: 20,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(width: 5),
                      Text(
                        data.title,
                        style: GoogleFonts.poppins(
                            color: Color(0xff696969),
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (String selectedId) {
                titleFN.unfocus();
                _controller.selectedConditionId.value = selectedId;
                _controller.conditionDesc.value = widget
                        .sellingController.conditions
                        .firstWhere((element) => element.id == selectedId,
                            orElse: null)
                        ?.condition ??
                    'Select the condition that fits best';
              },
              value: _controller.selectedConditionId.value.isEmpty
                  ? null
                  : _controller.selectedConditionId.value,
            ),
          ),
        ),
      );

  @override
  void initState() {
    _currentItemSelected = widget.categoryId;
    selectedPosition = currentPosition;
    addressFromLatLng(currentPosition.latitude, currentPosition.longitude);
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    // locationController.dispose();
    super.dispose();
  }

  void _onNextButtonClick() {
    if (GetUtils.isNullOrBlank(titleController.text)) {
      widget.sellingController
          .showMessage("Please provide the title for your product");
      return;
    }
    // print("selectedConditionId: ${_controller.selectedConditionId}");

    if (GetUtils.isNullOrBlank(_controller.selectedConditionId.value)) {
      widget.sellingController
          .showMessage("Please select the condition of your product");
      return;
    }

    if (GetUtils.isNullOrBlank(_controller.selectedAddress.value)) {
      widget.sellingController
          .showMessage("Please enter the address for your product");
      return;
    }

    //saving data
    widget.sellingController.requestData.categoryId = _currentItemSelected;
    widget.sellingController.requestData.images =
        widget.sellingController.imagedata;
    widget.sellingController.requestData.title = titleController.text;
    widget.sellingController.requestData.location =
        _controller.selectedAddress.value;
    widget.sellingController.requestData.latitude = selectedPosition.latitude;
    widget.sellingController.requestData.longitude = selectedPosition.longitude;
    widget.sellingController.requestData.conditionId =
        _controller.selectedConditionId.value;

    //then moving to next add_post screen
    widget.sellingController.step.value = 3;
  }
  openPlacePicker() async {
    LocationResult result = await showLocationPicker(context, google_map_key);
    if (result != null) {
      selectedPosition = Position(
          latitude: result.latLng.latitude, longitude: result.latLng.longitude);
      addressFromLatLng(result.latLng.latitude, result.latLng.longitude);
    }
  }

  addressFromLatLng(latitude, longitude) async {
    var addresses = await Geocoder.local
        .findAddressesFromCoordinates(Coordinates(latitude, longitude));
    var first = addresses.first;
    _controller.selectedAddress.value = first.addressLine;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  builddetail("Details")
                      .addOnlyPadding(top: 10, left: 20, right: 20, bottom: 0),
                  Container(
                    height: 130,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        Row(
                          children: [
                            Obx(
                              () => Container(
                                height: 130,
                                child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    cacheExtent: 99999,
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: widget
                                        .sellingController.imagedata.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        height: 135,
                                        width: 120,
                                        // color: Colors.blue,
                                        child: Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            Positioned(
                                              top: 20,
                                              left: 0,
                                              // right: 0,
                                              width: 110,
                                              child: Card(
                                                  margin: EdgeInsets.only(
                                                      right: 10),
                                                  clipBehavior: Clip.antiAlias,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  child: Container(
                                                    height: 110,
                                                    width: 110,
                                                    child: Image.file(
                                                      File(widget
                                                          .sellingController
                                                          .imagedata[index]
                                                          .path),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  )),
                                            ),
                                            getClearButton(index),
                                          ],
                                        ),
                                      );
                                    }).addOnlyPadding(left: 20),
                              ),
                            ),
                            Container(
                              child: Center(
                                child: FDottedLine(
                                  height: 60,
                                  width: 100.0,
                                  corner: FDottedLineCorner.all(8.0),
                                  color: Colors.black26,
                                  child: Center(
                                    child: Container(
                                      height: 50.0,
                                      width: 100.0,
                                      child: camera(context),
                                    ),
                                  ),
                                ),
                              ),
                            ).marginOnly(top: 16, bottom: 6)
                          ],
                        ),
                      ],
                    ),
                  ),

                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xffF2F2F2),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    width: double.maxFinite,
                    padding: EdgeInsets.only(left: 10, right: 15),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: borderColor,
                        ),
                        isExpanded: true,
                        items: widget.data.map((dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem.id,
                            child: Text(
                              dropDownStringItem.categoryname,
                              style: GoogleFonts.poppins(
                                  color: Color(0xff696969),
                                  fontWeight: FontWeight.w400),
                            ),
                          );
                        }).toList(),
                        onChanged: (String ValueSelected) {
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
                  textField(titleController, titleFN, "title"),
                  Text(
                    'Describe what you’re selling, in few words',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                        color: textColor,
                      ),
                    ),
                  ).addOnlyPadding(left: 20, top: 5),
                  conditionsDropdown.addOnlyPadding(
                      left: 20, right: 20, top: 20),
                  Obx(
                    () => Text(
                      _controller.conditionDesc.value,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                          color: textColor,
                        ),
                      ),
                    ).addOnlyPadding(left: 20, top: 5),
                  ),
                  InkWell(
                    onTap: () {
                      openPlacePicker();
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 24),
                      padding: const EdgeInsets.only(
                          left: 12, right: 16, top: 12, bottom: 12),
                      decoration: BoxDecoration(
                        color: Color(0xffF2F2F2),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Obx(
                              () => Text(
                                _controller.selectedAddress.value,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.6),
                                    fontSize: 16),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    'Where is listing located',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                        color: textColor,
                      ),
                    ),
                  ).addOnlyPadding(left: 20, top: 5),
                  32.toVerticalSpace(),
                  // Container(
                  //   width: double.maxFinite,
                  //   height: 60,
                  //   child: MaterialButton(
                  //     shape: RoundedRectangleBorder(),
                  //     onPressed: _onNextButtonClick,
                  //     color: primaryColor,
                  //     child: Center(
                  //       child: Text(
                  //         'Next',
                  //         style: GoogleFonts.sourceSansPro(
                  //           textStyle: TextStyle(
                  //             fontWeight: FontWeight.w400,
                  //             fontSize: 16,
                  //             color: Colors.white,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          Container(
            width: double.maxFinite,
            height: 60,
            child: MaterialButton(
              shape: RoundedRectangleBorder(),
              onPressed: _onNextButtonClick,
              color: primaryColor,
              child: Center(
                child: Text(
                  'Next',
                  style: GoogleFonts.sourceSansPro(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getClearButton(int index) {
    return IconButton(
      onPressed: () {
        // widget.homeController.getProduct();
        widget.sellingController.imagedata.removeAt(index);
        // temp.removeAt(position);
      },
      icon: SvgPicture.asset(
        AppImages.close,
        width: 15,
      ),
    );
  }

  Text builddetail(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 20,
          color: labeltextColor,
        ),
      ),
    );
  }

  Widget dotline() {
    return Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 15.0),
        child: FDottedLine(
          width: 78.0,
          space: 2.0,
          color: Colors.white,
          strokeWidth: 2.0,
        ));
  }

  Widget textField(
    TextEditingController controller,
    FocusNode focusNode,
    String text,
  ) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xffF2F2F2),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      width: Get.width,
      child: new TextFormField(
        autofocus: false,
        controller: controller,
        focusNode: focusNode,
        style: TextStyle(
          fontSize: 15.0,
        ),
        obscureText: false,
        autocorrect: false,
        decoration: new InputDecoration(
          hintText: text,
          border: UnderlineInputBorder(borderSide: BorderSide.none),
          contentPadding: EdgeInsets.all(12),
        ),
      ),
    ).addOnlyPadding(left: 20, right: 20, top: 20);
  }

  Container camera(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () {
          _showSelectionDialog(context);
        },
        child: Icon(Icons.camera_alt, color: Colors.grey, size: 50),
      ),
    );
  }

  Future<void> _showSelectionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("From where do you want to take the photo?"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text("Gallery").addInkwell(onClick: () {
                      _openGallery(context);
                    }),
                    Padding(padding: EdgeInsets.all(8.0)),
                    Text("Camera").addInkwell(onClick: () {
                      _openCamera(context);
                    }),
                  ],
                ),
              ));
        });
  }

  void _openGallery(BuildContext context) async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery, maxWidth: 800, maxHeight: 800);
    Navigator.of(context).pop();

    if (pickedFile != null) {
      file = File(pickedFile.path);
      var f = await FrequentUtils.getInstance().compressImagee(File(file.path));
      widget.sellingController.imagedata.add(f);
      setState(() {});
    } else {
      print('No image selected.');
    }
  }

  void _openCamera(BuildContext context) async {
    final pickedFile = await picker.getImage(
        source: ImageSource.camera, maxWidth: 800, maxHeight: 800);
    Navigator.of(context).pop();

    if (pickedFile != null) {
      file = File(pickedFile.path);
      var f = await FrequentUtils.getInstance().compressImagee(File(file.path));
      widget.sellingController.imagedata.add(f);
    } else {
      print('No image selected.');
    }
  }

  void _onDropDownItemSelected(String selectedId) {
    setState(() {
      this._currentItemSelected = selectedId;
      widget.sellingController.getSubCategoriesOnly(selectedId);
    });
  }
}

class ImageData {
  String image;

  ImageData({
    this.image,
  });
}
