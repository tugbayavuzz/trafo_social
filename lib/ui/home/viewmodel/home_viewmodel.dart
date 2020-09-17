import 'package:flutter/material.dart';
import 'package:travel_blog/ui/auth/service/auth_service.dart';
import 'package:travel_blog/ui/home/model/product_model.dart';
import 'package:travel_blog/ui/home/service/IHome_service.dart';
import 'package:travel_blog/ui/home/service/home_service.dart';
import 'package:travel_blog/ui/home/view/home.dart';

abstract class HomeViewModel extends State<Home> {
  bool isLoading = false;
  List<ProductModel> foodList = [];
  List<ProductModel> travelList = [];
  IHomeService homeService;
  static const storyListLength = 1000; // Dummy
  final AuthService _auth = AuthService();
  FutureBuilder futureBuilder;
  Future future;
  String get userPicUrl =>
      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"; //shared pref profil img

  @override
  void initState() {
    super.initState();
    homeService = HomeService();
    callItems();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> callItems() async {
    changeLoading();
    await getList();
    changeLoading();
  }

  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Future<void> getList() async {
    foodList = await homeService.getFoodList();
    travelList = await homeService.getTravelList();
  }

  Future signOut() async => await _auth.signOut();
}
