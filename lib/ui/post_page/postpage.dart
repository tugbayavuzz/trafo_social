import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:path/path.dart';
import 'package:travel_blog/core/base/model/user_model.dart';
import 'package:travel_blog/core/base/service/database_service.dart';
import 'package:travel_blog/ui/auth/service/auth_service.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyUI(),
    );
  }
}

class BodyUI extends StatefulWidget {
  @override
  _BodyUIState createState() => _BodyUIState();
}

class _BodyUIState extends State<BodyUI> {
  // ViewModel

  final sharedDate = DateTime.now().toString();
  String postImgUrl = '';

  Future<String> uploadImg() async {
    StorageReference imgPlace = FirebaseStorage.instance.ref().child(_imgPath);

    StorageUploadTask uploadTask = imgPlace.putFile(_img);

    var indirmeUrl = await (await uploadTask.onComplete).ref.getDownloadURL();

    postImgUrl = indirmeUrl.toString();

    print("indirme urlsi: " + postImgUrl);

    return postImgUrl;
  }

  File _img;
  String _imgPath;

  Future pickImg() async {
    File pickedImg = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _img = pickedImg;
      _imgPath = basename(pickedImg.path);
    });
  }

  Future post(String sharedDate, String sharedImgUrl, String sharedLat,
      String sharedLong, String sharedText) async {
    String uid = FirebaseAuth.instance.currentUser.uid;

    DatabaseService(uid: uid).updatePost(
        sharedDate, sharedImgUrl, sharedLat, sharedLong, sharedText);
  }

  // View
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          b1(),
          b2(),
          b3(),
          b4(),
          b5(),
          b6(),
          b7(),
          b8(),
        ],
      ),
    );
  }

  Widget yuklemeAlani() {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 20.0),
      height: 200,
      width: 330,
      child: Image.file(
        _img,
      ),
    );
  }

  InkWell b4() {
    return InkWell(
      onTap: pickImg,
      child: Container(
        margin:
            EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0, bottom: 20.0),
        height: 200.0,
        width: 330.0,
        color: Color(0XFFE3FAFC),
        child: DottedBorder(
            color: Colors.blueAccent,
            strokeWidth: 1,
            child: _img == null ? b41() : uploadImg()),
      ),
    );
  }

  Container b41() {
    return Container(
      padding: EdgeInsets.only(left: 60.0, top: 20.0),
      child: Column(
        children: [
          Container(
            height: 100,
            width: 200,
            child: SvgPicture.asset("assets/images/upload1.svg"),
          ),
          Icon(
            Icons.cloud_upload,
            color: Colors.blueAccent,
            size: 40.0,
          ),
          Text(
            "Upload a photo",
            style: GoogleFonts.montserrat(
                color: Colors.blueAccent,
                fontSize: 13.0,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  RaisedButton b8() {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0),
        side: BorderSide(
          color: Color(0xff83a4d4),
        ),
      ),
      onPressed: () {
        post(sharedDate, postImgUrl, '70.234', '68.342', 'Selamlar');
      },
      color: Color(0xff83a4d4),
      textColor: Colors.white,
      child: Text(
        "Publish Your Post".toUpperCase(),
        style: TextStyle(fontSize: 13),
      ),
      padding:
          EdgeInsets.only(left: 100.0, right: 100.0, top: 15.0, bottom: 15.0),
    );
  }

  Column b7() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 3),
              ),
            ],
          ),
          margin: EdgeInsets.all(20.0),
          child: new TextField(
            decoration: new InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(20.0),
                  ),
                ),
                filled: true,
                hintStyle: new TextStyle(color: Colors.grey[800]),
                hintText:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam vehicula ligula eu ligula placerat dapibus ut lobortis purus. Aliquam erat volutpat.",
                fillColor: Colors.white70),
          ),
        ),
      ],
    );
  }

  Container b6() {
    return Container(
      margin: EdgeInsets.only(left: 20.0, top: 20.0, bottom: 1.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Add a Text",
            style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }

  Container b5() {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0),
      height: 120.0,
      width: 400.0,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Opacity(
            opacity: 0.99,
            child: Container(
              height: 120.0,
              width: 140.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.center,
                  image: AssetImage(
                    "assets/images/art.png",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                margin: EdgeInsets.only(right: 10.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Chip(
                        label: new Text(
                          "X",
                          style: TextStyle(fontSize: 15.0),
                        ),
                        // deleteIcon: Icon(Icons.delete),
                        //deleteIconColor: Colors.black,
                      ),
                    ]),
              ),
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          margin: EdgeInsets.all(10),
        ),
      ),
    );
  }

  Container b3() {
    return Container(
      padding: EdgeInsets.only(left: 20.0, top: 10.0),
      child: Row(
        children: [
          FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Color(0xff83a4d4))),
            onPressed: () {},
            child: Text(
              "food".toUpperCase(),
              style: TextStyle(
                color: Color(0xff83a4d4),
                fontSize: 14.0,
              ),
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Color(0xff83a4d4))),
            onPressed: () {},
            color: Color(0xff83a4d4),
            textColor: Colors.white,
            child: Text("Travel".toUpperCase(), style: TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }

  Container b2() {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Row(
        children: [
          Text(
            "Select a category",
            style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }

  Container b1() {
    return Container(
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.only(top: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.arrow_back),
          Text(
            "Create a Post",
            style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.w400),
          ),
          Text(
            "Save Drafts",
            style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}
