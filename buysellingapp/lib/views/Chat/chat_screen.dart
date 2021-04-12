import 'dart:convert';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:untitled/Utils/sharedpref.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:untitled/WebServices/repository.dart';
import 'package:untitled/model/chat/ChatUserData.dart';
import 'package:untitled/model/chat/chatMessagesList/SendMessageRequest.dart';
import 'package:untitled/res/colors.dart';
import 'package:untitled/Utils/my_extensions.dart';
import 'getXController/chatScreenController.dart';

double betweenSpacing = 10;

class ChatScreen extends StatefulWidget {
  final ChatUserData chatListData;

  ChatScreen({Key key, @required this.chatListData}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final TextEditingController _messageTEC = TextEditingController();
  final String _myId = SharedPref.getInstance().getUserId();
  String _receiverId;

  IO.Socket _socketIO;
  final ScrollController _scrollController = ScrollController();

  final ChatScreenController _controller = ChatScreenController();

  static const String SOCKET_ADDRESS = "http://3.16.168.81:4000";

  @override
  void initState() {
    _receiverId = (widget.chatListData.userId == _myId)
        ? widget.chatListData.receiverId
        : widget.chatListData.userId;

    print(
        "My user id: ${SharedPref.getInstance().getUserId()} ${widget.chatListData.id}");

    Future.delayed(Duration(milliseconds: 100)).then((value) {
      _controller.getMessages(
          "$_myId${widget.chatListData.productId.id}$_receiverId",
          "$_receiverId${widget.chatListData.productId.id}$_myId",
          widget.chatListData.productId.id);
    });

    connectSocket();

    super.initState();
  }

  @override
  void dispose() {
    _messageTEC.dispose();
    _socketIO.disconnect();

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  _sendMessage({String message = ""}) {
    print("messag_sending...");

    SendMessageRequest req = SendMessageRequest(
      userId: _myId,
      receiverId: _receiverId,
      username: (widget.chatListData.userId == _myId)
          ? widget.chatListData.username
          : widget.chatListData.receivername,
      userPic: (widget.chatListData.userId == _myId)
          ? widget.chatListData.userPic
          : widget.chatListData.receiverPic,
      message: message,
      chatId: "$_receiverId${widget.chatListData.productId.id}$_myId",
      type:
          (widget.chatListData.productId.userId == _myId) ? "seller" : "buyer",
      productId: widget.chatListData.productId.id,
      receiverPic: (widget.chatListData.userId == _myId)
          ? widget.chatListData.receiverPic
          : widget.chatListData.userPic,
      receivername: (widget.chatListData.userId == _myId)
          ? widget.chatListData.receivername
          : widget.chatListData.username,
    );

    _socketIO.emit("sendMessage", req.toJson());
    print("message_req: ${jsonEncode(req.toJson())}");

    Map<String, dynamic> request = Map();
    request["userId"] = _myId;
    request["username"] = (widget.chatListData.userId == _myId)
        ? widget.chatListData.username
        : widget.chatListData.receivername;
    request["userPic"] = widget.chatListData.userPic;
    request["receiverId"] = _receiverId;
    request["receivername"] = widget.chatListData.receivername;
    request["receiverPic"] = widget.chatListData.receiverPic;
    request["chatId"] = "$_receiverId${widget.chatListData.productId.id}$_myId";
    request["type"] =
        (widget.chatListData.productId.userId == _myId) ? "seller" : "buyer";
    request["message"] = message;
    request["productId"] =
        widget.chatListData.productId; //changing for my purpose

    _controller.addMessage(request);

    // Clear Text Field
    _messageTEC.clear();

    if (_controller.chatList.length != 0) _scrollController.jumpTo(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        leading: Icon(Icons.arrow_back_ios).addInkwell(onClick: () {
          Navigator.pop(context);
        }),
        titleSpacing: -12,
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  shape: BoxShape.circle),
              child: ClipOval(
                child: ((widget.chatListData?.receiverPic ?? "").isNotEmpty) ||
                        ((widget.chatListData?.userPic ?? "").isNotEmpty)
                    ? Image.network(
                        (widget.chatListData.userId ==
                                SharedPref.instancee.getUserId())
                            ? Repository.profileImageUrl +
                                widget.chatListData.receiverPic
                            : Repository.profileImageUrl +
                                widget.chatListData.userPic,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: 40,
                        height: 40,
                        color: Colors.black12,
                      ),
              ),
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (widget.chatListData.userId ==
                          SharedPref.instancee.getUserId())
                      ? widget.chatListData?.receivername ?? ""
                      : widget.chatListData?.username ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  widget.chatListData?.productId?.title ?? "",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 14,
                  ),
                ),
                Text(
                  "\$ ${widget.chatListData?.productId?.price ?? ""}",
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.5), fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [Expanded(child: chatListView()), bottomView],
      ),
    );
  }

  Widget chatListView() {
    return Obx(() {
      return ListView.builder(
        controller: _scrollController,
        physics: BouncingScrollPhysics(),
        reverse: true,
        shrinkWrap: true,
        cacheExtent: 99999,
        itemCount: (_controller.chatList.isNotNullOrEmpty())
            ? _controller.chatList.length
            : 0,
        itemBuilder: (BuildContext context, int index) {
          return _controller.chatList[index].userId !=
                  SharedPref.getInstance().getUserId()
              ? otherMsg(index)
              : myMsg(index);
        },
      ).addPadding(12);
    });
  }

  Widget myMsg(int index) {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Bubble(
              margin: const BubbleEdges.only(top: 5, bottom: 5),
              alignment: Alignment.topRight,
              nipWidth: 8,
              nipHeight: 9,
              nip: BubbleNip.rightBottom,
              child: (Text(_controller.chatList[index].message,
                      textAlign: TextAlign.right)
                  .addPadding(6))
              //assuming it will be a base64 String,
              ),
        ],
      ),
    );
  }

  Widget otherMsg(int index) {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Bubble(
            margin: const BubbleEdges.only(top: 5, bottom: 5),
            alignment: Alignment.topLeft,
            nipWidth: 8,
            nipHeight: 9,
            nip: BubbleNip.leftTop,
            color: primaryColor,
            child: Text(_controller.chatList[index].message)
                .addTextStyle(TextStyle(color: Colors.white))
                .addPadding(6),
          ),
        ],
      ),
    );
  }

  Widget get bottomView {
    return Container(
      child: PhysicalModel(
        elevation: 1,
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(122)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // emo,
            editTextView,
            CircleAvatar(
              backgroundColor: primaryColor,
              child: RotatedBox(
                quarterTurns: 4,
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
            ).addInkwell(onClick: () {
              if (_messageTEC.text.isNotEmpty) {
                _sendMessage(message: _messageTEC.text ?? "");
              }
            })
          ],
        ).addPadding(8),
      ),
    ).addPadding(8);
  }

  // Widget get emo {
  //   return imageView(
  //     path: AppImages.attach,
  //     padding: betweenSpacing,
  //     callBack: () async {
  //       await _controller.showPhotoPickDialog(context, (File file) {
  //         if (file != null) {
  //           var base64 = _controller.convertImageToBase64(file);
  //           print("base-64: ${base64}");
  //           _sendMessage(type: DATA_TYPE_FILE, base64: base64);
  //         }
  //       });
  //     },
  //   );
  // }

  Widget get editTextView {
    return Expanded(
      child: Container(
        child: TextField(
          controller: _messageTEC,
          maxLines: 30,
          minLines: 1,
          decoration: InputDecoration.collapsed(
              hintText: "Type your message...", border: InputBorder.none),
        ),
        padding: EdgeInsets.only(left: betweenSpacing, right: betweenSpacing),
      ),
    );
  }

  Widget imageView(
      {String path, double padding = 0, GestureTapCallback callBack}) {
    return GestureDetector(
      onTap: callBack,
      child: Container(
          child: SvgPicture.asset(
            path,
            width: 24,
            height: 24,
            color: primaryColor,
          ),
          padding: EdgeInsets.all(padding)),
    );
  }

  connectSocket() {
    _socketIO = IO.io(SOCKET_ADDRESS, <String, dynamic>{
      'transports': ['websocket'],
      'force new connection': true,
      'extraHeaders': {'foo': 'bar'} // optional
    });

    _socketIO.on('connect', (_) {
      print("connected_on :- $SOCKET_ADDRESS");

      print(
          "room_object: $_myId${widget.chatListData.productId.id}$_receiverId");
      _socketIO.emit(
          "join", "$_myId${widget.chatListData.productId.id}$_receiverId");
    });

    _socketIO.on('connecting', (_) => print('Socket Connecting'));
    _socketIO.on('disconnect', (_) => print('Socket Disconnected'));
    _socketIO.on('connect_error', (_) => print('Socket Connection Error'));

    _socketIO.on("receivedMessage", (data) {
      print("Listener_receiver2: ${data.toString()}");
      if (data != null && data is Map) {
        Map<String, dynamic> request = Map();
        request["userId"] = _receiverId;
        request["username"] = widget.chatListData.username;
        request["userPic"] = widget.chatListData.userPic;
        request["receiverId"] = _myId;
        request["receivername"] = widget.chatListData.receivername;
        request["receiverPic"] = widget.chatListData.receiverPic;
        request["productId"] = widget.chatListData.productId;
        request["chatId"] = data["chatId"];
        request["type"] = data["type"];
        request["message"] = data["message"] ?? "";

        _controller.addMessage(request);
      }
    });
  }
}
