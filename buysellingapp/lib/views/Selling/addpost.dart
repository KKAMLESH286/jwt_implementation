import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/WebServices/repository.dart';
import 'package:untitled/res/colors.dart';
import 'package:untitled/silverstaggeredgridviewandfixedheight.dart';
import 'package:untitled/views/Selling/selling_controller.dart';
import 'package:untitled/Utils/my_extensions.dart';

import 'addPostScreen.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  bool isLoading = false;
  final SellingController sellingController = SellingController();

  @override
  void initState() {
    sellingController.getCurrentLocation();
    Future.delayed(Duration(milliseconds: 100)).then((value) {
      isLoading = true;
      sellingController.getCategoryApi();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: primaryColor,
              height: 80.0,
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerLeft,
              child: Text(
                'What are You Posting?',
                style: TextStyle(color: Colors.white, fontSize: 22.0),
              ),
            ),
            20.toVerticalSpace(),
            Expanded(
              child: Obx(
                () => Container(
                  padding: EdgeInsets.only(left: 10.0, right: 8.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: sellingController?.data?.length ?? 0,
                    physics: BouncingScrollPhysics(),
                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                            crossAxisCount: 3,
                            height: 135,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                    itemBuilder: (context, index) {
                      return Container(
                        child: post_item(index),
                      ).addInkwell(onClick: () {
                        sellingController.tapped.value = index;
                        Get.to(AddPostScreen(
                          sellingController,
                          sellingController.data[index].id,
                          sellingController.data.value,
                          index,
                          sellingController.tapped.value,
                        ));
                        print("data${sellingController.data.value}");
                      });
                    },
                  ),
                ),
              ), //
            ),
            20.toVerticalSpace(),
          ],
        ),
      ),
    );
  }

  bool selected = false;

  Widget post_item(int index) {
    return Card(
      color: sellingController.tapped.value == index
          ? Colors.redAccent
          : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: sellingController.tapped.value == index ? 4.0 : 0.0,
      shadowColor: Colors.black.withOpacity(0.6),
      child: Tooltip(
        message: sellingController.data[index]?.categoryname ?? "",
        child: Column(
          children: [
            // selection radio show
            Padding(
              padding: const EdgeInsets.only(right: 6.0, top: 6.0),
              child: sellingController.tapped.value == index
                  ? Container(
                      height: 14,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          width: 14,
                          height: 14,
                          padding: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 1),
                              borderRadius: BorderRadius.circular(7)),
                          child: CircleAvatar(
                            maxRadius: 8.0,
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      height: 14,
                    ),
            ),
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: (sellingController?.data[index]?.image ?? "").isNotEmpty
                  ? Image.network(
                      Repository.cat_imageUrl +
                              sellingController?.data[index]?.image ??
                          "",
                      fit: BoxFit.fill,
                    )
                  : SizedBox.expand(),
            ),
            Padding(
              padding: const EdgeInsets.all(6),
              child: Center(
                child: Semantics(
                  label: "category_name",
                  child: Text(
                    sellingController.data[index]?.categoryname ?? "",
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 12,
                        color: sellingController.tapped.value == index
                            ? Colors.white
                            : Colors.grey),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
