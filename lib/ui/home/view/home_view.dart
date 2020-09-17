import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_blog/core/base/service/database_service.dart';
import 'package:travel_blog/ui/auth/service/auth_service.dart';
import 'package:travel_blog/ui/detail/view/detail.dart';
import 'package:travel_blog/ui/home/model/card_model.dart';
import 'package:travel_blog/ui/home/view/post_list.dart';
import 'package:travel_blog/ui/home/viewmodel/home_viewmodel.dart';
import 'package:travel_blog/core/constants/constants.dart';
import 'package:travel_blog/ui/post_page/postpage.dart';
import 'package:travel_blog/ui/profile_page/view/profile.dart';

class HomeView extends HomeViewModel {
  static const storyListLength = 1000; // Dummy
  final AuthService _auth = AuthService();
  CardModel dummyCardTravel = CardModel(
      "https://cdn.pixabay.com/photo/2018/07/26/07/45/valais-3562988_1280.jpg",
      "https://cdn.pixabay.com/photo/2016/03/31/19/56/avatar-1295397_960_720.png",
      "Grant Marshall",
      "January 9,2020",
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry.");
  CardModel dummyCardFood = CardModel(
      "https://cdn.pixabay.com/photo/2018/07/26/07/45/valais-3562988_1280.jpg",
      "https://cdn.pixabay.com/photo/2016/03/31/19/56/avatar-1295397_960_720.png",
      "Grant Marshall",
      "January 9,2020",
      "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...");
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    CardModel card;
    switch (_index) {
      case 0:
        card = dummyCardFood;
        break;
      case 1:
        card = dummyCardTravel;
        break;
    }
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().posts,
      child: Scaffold(
        appBar: buildAppBar(card.userPicUrl),
        body: PostList(),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _index,
            onTap: (index) {
              setState(() {
                _index = index;
              });
            },
            items: [
              buildBottomNavigationBarItem('Food', Icons.ac_unit),
              buildBottomNavigationBarItem('Travel', Icons.ac_unit),
            ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => PostPage()));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  AppBar buildAppBar(String userPicUrl) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      leading: buildIconButtonProfile(userPicUrl),
      title: buildTextMainTitle('Feed'),
      actions: [
        buildIconButtonSearch(),
        buildFlatButtonLogOut(),
      ],
    );
  }

  FlatButton buildFlatButtonLogOut() {
    return FlatButton.icon(
        onPressed: () async {
          await _auth.signOut();
        },
        icon: Icon(Icons.exit_to_app),
        label: Text(
          'Log out',
        ));
  }

  IconButton buildIconButtonProfile(String userPicUrl) {
    return IconButton(
      icon: homeUserProfileImg(userPicUrl),
      color: Colors.black,
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Profile()));
      },
    );
  }

  Text buildTextMainTitle(String title) {
    return Text(
      title,
      style: AppConstants.appTextStyleTitle,
    );
  }

  IconButton buildIconButtonSearch() {
    return IconButton(
      icon: Icon(Icons.search),
      iconSize: MediaQuery.of(context).size.width * 0.08,
      onPressed: () {},
      color: Colors.black,
    );
  }

  ListView buildListViewStories(CardModel card) {
    return ListView.builder(
        itemCount: storyListLength,
        itemBuilder: (context, index) {
          return homeBody(card);
        });
  }

  Widget homeBody(CardModel card) {
    return Padding(
      padding: EdgeInsets.all(AppConstants.homeBodyPadding),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppConstants.homeCardRadius),
          ),
        ),
        child: Column(
          children: [
            homeCard(card.imgUrl),
            homeUserContainer(card.userPicUrl, card.userName, card.shareDate),
            homeContentText(card.briefContent),
          ],
        ),
      ),
    );
  }

  Center homeCard(String imgUrl) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppConstants.homeCardRadius),
          ),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.width * 0.45,
          child: ClipRRect(
            borderRadius:
                BorderRadius.all(Radius.circular(AppConstants.homeCardRadius)),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Detail()));
                },
                child: Image.network(imgUrl, fit: BoxFit.fill)),
          ),
        ),
      ),
    );
  }

  Widget homeUserContainer(
      String userPicUrl, String userName, String shareDate) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          homeUserProfileImg(userPicUrl),
          homeUserNameAndSharedDate(userName, shareDate),
          Spacer(),
          homeUserIconList()
        ],
      ),
    );
  }

  Container homeUserProfileImg(String userPicUrl) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.1,
      width: MediaQuery.of(context).size.width * 0.1,
      child: ClipRRect(
        borderRadius:
            BorderRadius.all(Radius.circular(AppConstants.homeUserRadius)),
        child: Image.network(
          userPicUrl,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Padding homeUserNameAndSharedDate(String userName, String shareDate) {
    return Padding(
      padding: EdgeInsets.only(
          left: AppConstants.homeUserNameAndSharedDatePaddingLeft),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.35,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            homeUserNameText(userName),
            homeSharedDateText(shareDate),
          ],
        ),
      ),
    );
  }

  Text homeUserNameText(String userName) {
    return Text(
      userName,
      style: AppConstants.appTextStyleUserName,
    );
  }

  Text homeSharedDateText(String shareDate) {
    return Text(
      shareDate,
      style: AppConstants.appTextStyleShareDate,
    );
  }

  Row homeUserIconList() {
    return Row(
      children: [
        IconButton(icon: Icon(Icons.location_on), onPressed: () {}),
        IconButton(icon: Icon(Icons.favorite), onPressed: () {}),
        IconButton(icon: Icon(Icons.bookmark_border), onPressed: () {})
      ],
    );
  }

  Padding homeContentText(String content) {
    return Padding(
      padding: EdgeInsets.all(AppConstants.homeContentTextPadding),
      child: Column(
        children: [
          Text(content, textAlign: TextAlign.justify),
        ],
      ),
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem(
      String text, IconData icon) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      title: Text(text),
    );
  }
}
