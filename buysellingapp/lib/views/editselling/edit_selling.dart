import 'dart:io';
import 'dart:math';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:untitled/model/Listing/Selling/Image.dart' as sellingImage;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';

import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/Utils/frequent_utils.dart';
import 'package:untitled/Utils/my_extensions.dart';
import 'package:untitled/WebServices/repository.dart';
import 'package:untitled/model/editlisting/editListdata.dart';
import 'package:untitled/res/colors.dart';
import 'package:untitled/res/string.dart';
import 'package:untitled/silverstaggeredgridviewandfixedheight.dart';
import 'package:untitled/views/Listing/getXController/my_listing_controller.dart';
import 'package:untitled/model/Listing/Selling/Data.dart' as sellingData;
import 'package:untitled/views/editselling/editSellingController.dart';

class EditSelling extends StatefulWidget {
  final sellingData.Data sellingList;
  EditSelling(this.sellingList);
  @override
  _EditSellingState createState() => _EditSellingState();
}

class _EditSellingState extends State<EditSelling> {
  var editSellingcontroller = EditSellingController();
  List<EditData> editData = [];
  File avatar;
  String type;
  String url;
  List<File> files = [];
  var _currentItemSelected = "fasdf";
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descController = TextEditingController();
  final FocusNode titleFN = FocusNode();
  Position selectedPosition;

  void addimage() {
    // widget.sellingList.images.addAll(editData);
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.sellingList.images.length; i++) {
      editData.add(new EditData(
          file: null, type: "link", url: widget.sellingList.images[i].image));

      titleController = TextEditingController(text: widget.sellingList.title);
      priceController =
          TextEditingController(text: "\$${widget.sellingList?.price ?? ""}");
      descController =
          TextEditingController(text: widget.sellingList.description);
      // widget.sellingList.images = List.from(editData);
    }
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
    // editSellingcontroller.selectedAddress.value = first.addressLine;
  }

  File file;
  final picker = ImagePicker();
  List brand = ["fasdf", "fsdaf"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryColor,
        title: Text("Edit listing"),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: Get.height * 1.2,
          // height: MediaQuery.of(context).size.height*0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              builddetail("Details")
                  .addOnlyPadding(top: 10, left: 20, right: 20, bottom: 10),
              Container(
                height: 120,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    Row(
                      children: [
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            cacheExtent: 99999,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: editData.length,
                            itemBuilder: (context, index) {
                              return Card(
                                  margin: EdgeInsets.only(right: 10),
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Container(
                                    height: 120,
                                    width: 120,
                                    child: editData[index].type == "link"
                                        ? Image.network(Repository.imageUrl +
                                            editData[index].url)
                                        : editData[index].type == "file"
                                            ?
                                            // Image.file(File(file.path),
                                            Image.file(
                                                File(editData[index].file.path),
                                                fit: BoxFit.fill)
                                            : Container(),
                                  ));
                            }).addOnlyPadding(left: 20),
                        Container(
                          // margin: EdgeInsets.all(20.0),
                          child: Center(
                            child: FDottedLine(
                              height: 120,
                              width: 120.0,
                              corner: FDottedLineCorner.all(8.0),
                              color: Colors.black26,
                              child: Center(
                                child: Container(
                                  height: 120.0,
                                  width: 120.0,
                                  child: camera(context),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              /// Todo add categories
              // Container(
              //   decoration: BoxDecoration(
              //       color: Color(0xffF2F2F2),
              //       borderRadius: BorderRadius.all(Radius.circular(5))),
              //   width: double.maxFinite,
              //   padding: EdgeInsets.only(left: 10, right: 15),
              //   child: DropdownButtonHideUnderline(
              //     child: DropdownButton<String>(
              //       icon: Icon(
              //         Icons.keyboard_arrow_down,
              //         color: borderColor,
              //       ),
              //       isExpanded: true,
              //       items: widget.data.map((dropDownStringItem) {
              //         return DropdownMenuItem<String>(
              //           value: dropDownStringItem.id,
              //           child: Text(
              //             dropDownStringItem.categoryname,
              //             style: GoogleFonts.poppins(
              //                 color: Color(0xff696969),
              //                 fontWeight: FontWeight.w400),
              //           ),
              //         );
              //       }).toList(),
              //       onChanged: (String ValueSelected) {
              //         _onDropDownItemSelected(ValueSelected);
              //       },
              //       value: _currentItemSelected,
              //     ),
              //   ),
              // ).addOnlyPadding(left: 20, right: 20, top: 20),
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

              /// Todo add subcategories

              // Container(
              //   height: 130,
              //   child: GridView.builder(
              //     physics: NeverScrollableScrollPhysics(),
              //     padding: EdgeInsets.only(
              //       top: 10,
              //     ),
              //     shrinkWrap: true,
              //     itemCount: widget.sellingList?.s ?? 0,
              //     gridDelegate:
              //         SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
              //       crossAxisCount: 3,
              //       crossAxisSpacing: 10,
              //       mainAxisSpacing: 14,
              //       height: 48.0, //48 dp of height
              //     ),
              //     itemBuilder: (context, index) {
              //       return GestureDetector(
              //         onTap: () {
              //           // addProductController.tappedSubCat.value = index;
              //         },
              //         child: Obx(
              //           () => Container(
              //               width: Get.width * 0.3,
              //               height: Get.height * 0.06,
              //               decoration: BoxDecoration(
              //                 // color: addProductController.tappedSubCat.value ==
              //                 //         index
              //                 //     ? primaryColor
              //                 //     : Colors.white,
              //                 borderRadius: BorderRadius.circular(25.0),
              //                 border: Border.all(color: borderColor),
              //               ),
              //               child: Center(
              //                 // child: Text(
              //                 //   widget.sellingController?.subCategories[index]
              //                 //           .subcategoryname ??
              //                 //       "",
              //                 //   textAlign: TextAlign.center,
              //                 //   style: TextStyle(
              //                 //     color:
              //                 //         addProductController.tappedSubCat.value ==
              //                 //                 index
              //                 //             ? Colors.white
              //                 //             : Colors.grey,
              //                     fontSize: 16.0,
              //                   ),
              //                 ),
              //               )),
              //         ),
              //       );
              //     },
              //   ),
              // ).addOnlyPadding(left: 13, right: 15),
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
              Container(
                color: Color(0xffF2F2F2),
                width: Get.width,
                child: new TextFormField(
                  autofocus: false,
                  controller: priceController,
                  // focusNode: addProductController.priceFN,
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                  obscureText: false,
                  autocorrect: false,
                  keyboardType: TextInputType.number,
                  decoration: new InputDecoration(
                    hintText: 'Price',
                    border: UnderlineInputBorder(borderSide: BorderSide.none),
                    contentPadding: EdgeInsets.all(12),
                  ),
                ),
              ).addOnlyPadding(left: 20, right: 20, bottom: 10, top: 10),
              Text(
                'Set a competitive price',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    color: textColor,
                  ),
                ),
              ).addOnlyPadding(left: 15, bottom: 30),

              Container(
                color: Color(0xffF2F2F2),
                padding: EdgeInsets.only(left: 0, right: 0),
                width: Get.width,
                child: new TextFormField(
                  maxLines: 2,
                  autofocus: false,
                  controller: descController,
                  // focusNode: addProductController.descriptionFN,
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                  obscureText: false,
                  autocorrect: false,
                  decoration: new InputDecoration(
                    hintText: 'Description',
                    border: UnderlineInputBorder(borderSide: BorderSide.none),
                    contentPadding: EdgeInsets.all(12),
                  ),
                ),
              ).addOnlyPadding(left: 20, right: 20),
              Text(
                'Describe',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    color: textColor,
                  ),
                ),
              ).addOnlyPadding(left: 15, bottom: 10),
              // Container(
              //   decoration: BoxDecoration(
              //       color: Color(0xffF2F2F2),
              //       borderRadius: BorderRadius.all(Radius.circular(5))),
              //   width: double.maxFinite,
              //   padding: EdgeInsets.only(left: 10, right: 15),
              //   child: DropdownButtonHideUnderline(
              //     child: DropdownButton<String>(
              //       icon: Icon(
              //         Icons.keyboard_arrow_down,
              //         color: borderColor,
              //       ),
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
              // ).addOnlyPadding(left: 20, right: 20, top: 20),

              // textField(locationController, locationFN, "Type address here...."),

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
                        child: Text(
                          widget.sellingList.location,
                          // _controller.selectedAddress.value,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 16),
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
              Spacer(),
              Container(
                width: double.maxFinite,
                height: 60,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(),
                  onPressed: () {
                    editSellingcontroller.editProduct(
                        avatar,
                        titleController.text.trim().toString(),
                        priceController.text.trim().toString(),
                        descController.text.trim().toString());
                  },
                  color: primaryColor,
                  child: Center(
                    child: Text(
                      'Save',
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
        ),
      ),
    );
  }

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
              items: brand.map((dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Row(
                    children: [
                      // Image.network(
                      //   Repository.condition_imageUrl + data.image,
                      //   height: 20,
                      //   width: 20,
                      //   fit: BoxFit.fill,
                      // ),
                      SizedBox(width: 5),
                      Text(
                        dropDownStringItem,
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

                // _controller.selectedConditionId.value = selectedId;
                // _controller.conditionDesc.value = widget
                //     .sellingController.conditions
                //     .firstWhere((element) => element.id == selectedId,
                //     orElse: null)
                //     ?.condition ??
                'Select the condition that fits best';
              },
              // value: _controller.selectedConditionId.value.isEmpty
              //     ? null
              // : _controller.selectedConditionId.value,
            ),
          ),
        ),
      );
  Widget textField(
    TextEditingController titlecontroller,
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
        controller: titlecontroller,
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

  void _onDropDownItemSelected(String selectedId) {
    setState(() {
      this._currentItemSelected = selectedId;
      // widget.sellingController.fetchConditionsAndSubCategories(selectedId);
    });
  }

  void _openGallery(BuildContext context) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    Navigator.of(context).pop();

    if (pickedFile != null) {
      file = File(pickedFile.path);
      var f = await FrequentUtils.getInstance().compressImagee(File(file.path));
      // widget.sellingList.images.add(f);
      setState(() {
        file = File(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }

  void _openCamera(BuildContext context) async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    Navigator.of(context).pop();

    if (pickedFile != null) {
      file = File(pickedFile.path);
      var f = await FrequentUtils.getInstance().compressImagee(File(file.path));
      // .add(f);
    } else {
      print('No image selected.');
    }
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
}
