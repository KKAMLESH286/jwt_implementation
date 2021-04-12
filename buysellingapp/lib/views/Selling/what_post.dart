// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:untitled/res/images.dart';
// import 'package:untitled/views/addone/add_one.dart';
//
// class WhatSelling extends StatefulWidget {
//   @override
//   _WhatSellingState createState() => _WhatSellingState();
// }
//
// class _WhatSellingState extends State<WhatSelling> {
//   List<Post_Items> post_list = [
//     Post_Items('Electronics', Colors.blueAccent,
//         SvgPicture.asset(AppImages.footbal), true),
//     Post_Items('Sports', Colors.greenAccent,
//         SvgPicture.asset(AppImages.footbal), true),
//     Post_Items('Cars', Colors.amber, SvgPicture.asset(AppImages.home), true),
//     Post_Items('Electronics', Colors.blueAccent,
//         SvgPicture.asset(AppImages.smartphone), true),
//     Post_Items('Sports', Colors.greenAccent,
//         SvgPicture.asset(AppImages.footbal), true),
//     Post_Items('Cars', Colors.amber, SvgPicture.asset(AppImages.home), true),
//     Post_Items('Electronics', Colors.blueAccent,
//         SvgPicture.asset(AppImages.smartphone), true),
//     Post_Items('Sports', Colors.greenAccent,
//         SvgPicture.asset(AppImages.footbal), true),
//     Post_Items('Cars', Colors.amber, SvgPicture.asset(AppImages.home), true),
//     Post_Items('Electronics', Colors.blueAccent,
//         SvgPicture.asset(AppImages.smartphone), true),
//     Post_Items('Sports', Colors.greenAccent,
//         SvgPicture.asset(AppImages.footbal), true),
//     Post_Items('Cars', Colors.amber, SvgPicture.asset(AppImages.home), true),
//     Post_Items('Electronics', Colors.blueAccent,
//         SvgPicture.asset(AppImages.smartphone), true),
//     Post_Items('Sports', Colors.greenAccent,
//         SvgPicture.asset(AppImages.footbal), true),
//     Post_Items('Cars', Colors.amber, SvgPicture.asset(AppImages.home), true),
//     Post_Items('Electronics', Colors.blueAccent,
//         SvgPicture.asset(AppImages.smartphone), true),
//     Post_Items('Sports', Colors.greenAccent,
//         SvgPicture.asset(AppImages.footbal), true),
//     Post_Items('Cars', Colors.amber, SvgPicture.asset(AppImages.home), true),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Container(
//             color: Colors.redAccent,
//             height: 115.0,
//             child: Padding(
//               padding: const EdgeInsets.only(
//                 left: 20.0,
//               ),
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 30.0,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Icon(
//                         Icons.keyboard_backspace,
//                         color: Colors.white,
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 15.0,
//                   ),
//                   Row(
//                     children: [
//                       Text(
//                         'What are You Posting?',
//                         style: TextStyle(color: Colors.white, fontSize: 26.0),
//                       )
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             child: Container(
//               padding: EdgeInsets.only(left: 10.0, right: 10.0),
//               child: GridView.count(
//                 crossAxisCount: 3,
//                 shrinkWrap: true,
//                 physics: BouncingScrollPhysics(),
//                 children: List.generate(
//                   post_list.length,
//                   (index) {
//                     return Container(
//                       margin: EdgeInsets.all(5.0),
//                       child: post_item(index),
//                       // child: AspectRatio(aspectRatio: 3/2,
//                       //   child: Container(
//                       //     // padding: EdgeInsets.all(10.0),
//                       //     margin: EdgeInsets.all(2.0),
//                       //     child: post_item(index),
//                       //     // color: Colors.orange,
//                       //   ),
//                       // ),
//                     );
//                     //  post_item(index);
//                   },
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   int selectedIndex = -1;
//
//   Widget post_item(int index) {
//     return InkWell(
//       child: AnimatedContainer(
//         decoration: BoxDecoration(
//           color: post_list[index].selected ? Colors.white : Colors.redAccent,
//           borderRadius: BorderRadius.circular(15.0),
//         ),
//         // margin: EdgeInsets.only(left: 3.0,right: 3.0),
//         duration: Duration(seconds: 1),
//         curve: Curves.decelerate,
//         //  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),),
//
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(right: 8.0, top: 5.0),
//               child: post_list[index].selected
//                   ? Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         CircleAvatar(
//                           maxRadius: 8.0,
//                           backgroundColor: Colors.white,
//                         )
//                       ],
//                     )
//                   : Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         CircleAvatar(
//                           maxRadius: 8.0,
//                           backgroundColor: Colors.white,
//                           child: CircleAvatar(
//                             backgroundColor: Colors.redAccent,
//                             maxRadius: 6.0,
//                             child: CircleAvatar(
//                               backgroundColor: Colors.white,
//                               maxRadius: 4.0,
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                     child: Center(
//                   child: CircleAvatar(
//                     maxRadius: 25.0,
//                     backgroundColor: post_list[index].colorname,
//                     child: post_list[index].img,
//                   ),
//                 )),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     post_list[index]._name,
//                     style: TextStyle(
//                         color: post_list[index].selected
//                             ? Colors.black54
//                             : Colors.white),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//       onTap: () {
//         if (selectedIndex != -1) {
//           post_list[selectedIndex].selected = true;
//         }
//         selectedIndex = index;
//         post_list[index].selected = false;
//         setState(() {});
//         Get.to(Add_ImgStep1());
//       },
//     );
//   }
// // String imgurl;
// //   SvgPicture image;
// // Widget icons(int index){
// //     return
// //
// //
// // }
// }
//
// class Post_Items {
//   String _name;
//   Color colorname;
//   SvgPicture img;
//
//   // Image photo;
//   bool selected;
//
//   Post_Items(this._name, this.colorname, this.img, this.selected);
// }
