import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/Utils/sharedpref.dart';
import 'package:untitled/WebServices/repository.dart';
import 'package:untitled/model/chat/ChatUserData.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:untitled/res/colors.dart';
import 'chat_screen.dart';
import 'getXController/chatUsersController.dart';

class ChatAllScreen extends StatefulWidget {
  @override
  _ChatAllScreenState createState() => _ChatAllScreenState();
}

class _ChatAllScreenState extends State<ChatAllScreen> {
  final ChatUsersController _controller = ChatUsersController();

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 100)).then((value) {
      _controller.getChatUsers();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: primaryColor,
          title: Text(
            "Chat",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.only(right: 20),
          //     child: Icon(Icons.search, color: Colors.white),
          //   )
          // ],
          bottom: TabBar(
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 5.0,
                color: Colors.white,
              ),
              // insets: EdgeInsets.symmetric(horizontal:10.0),
            ),
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            unselectedLabelColor: Colors.white,
            tabs: [
              Tab(
                text: 'ALL',
              ),
              Tab(
                text: 'BUYING',
              ),
              Tab(
                text: 'SELLING',
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 20),
                Expanded(
                  child: TabBarView(
                    children: [
                      Obx(() => (_controller.haveUsers)
                          ? _usersList(_controller.allChats)
                          : _noUserPlaceholder),
                      Obx(() => (_controller.haveBuyingUsers)
                          ? _usersList(_controller.buyingChats)
                          : _noUserPlaceholder),
                      Obx(() => (_controller.haveSellingUsers)
                          ? _usersList(_controller.sellingChats)
                          : _noUserPlaceholder),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _usersList(List<ChatUserData> users) {
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: users.length,
          cacheExtent: 99999,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Get.to(ChatScreen(chatListData: users[index]));
              },
              child: _buildUsersListItems(users, index),
            );
          }),
    );
  }

  Container _buildUsersListItems(List<ChatUserData> users, int index) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipOval(
                child: ((users[index]?.receiverPic ?? "").isNotEmpty) ||
                        ((users[index]?.userPic ?? "").isNotEmpty)
                    ? Image.network(
                        (users[index].userId ==
                                SharedPref.instancee.getUserId())
                            ? Repository.profileImageUrl +
                                users[index]?.receiverPic
                            : Repository.profileImageUrl +
                                users[index]?.userPic,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: 60,
                        height: 60,
                        color: Colors.black12,
                      ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    (users[index].userId ==
                                            SharedPref.instancee.getUserId())
                                        ? users[index].receivername ?? ""
                                        : users[index].username ?? "",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 5),
                                Text(
                                  users[index].productId?.title ?? "",
                                  style: TextStyle(color: Color(0XFF7C7D7E)),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "\$ ${users[index].productId?.price ?? ""}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              timeago.format(DateTime.parse(
                                  users[index].updatedAt)),
                              style: TextStyle(color: Color(0XFF7C7D7E)),
                            ),
                            // SizedBox(height: 8),
                            // Padding(
                            //   padding: const EdgeInsets.only(right: 0.0),
                            //   child: Icon(
                            //     Icons.more_vert,
                            //     size: 28,
                            //     color: Colors.black45,
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Divider(
                      height: 20,
                      color: Colors.grey,
                    )
                  ],
                ).paddingOnly(left: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget get _noUserPlaceholder {
    return Center(
      child: Text("No users yet"),
    );
  }
}

class Profile {
  Profile(this.image, this.text, this.text1, this.text2, this.value, this.icon);

  String image;
  String text;
  String text1;
  String text2;
  String value;
  String icon;
}
