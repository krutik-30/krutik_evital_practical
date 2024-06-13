import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:krutik_evital_practical/Model/user_model.dart';
import 'dart:math';

class HomeController extends GetxController {
  List<User> allUsers = [];
  List<User> displayedUsers = [];
  final List<String> sampleNames = [
    'John Doe',
    'Jane Smith',
    'Alex Johnson',
    'Emily Davis',
    'Michael Brown',
    'Sarah Wilson',
    'David Clark',
    'Linda Lewis',
    'Robert Lee',
    'Jessica White'
  ];
  final List<String> sampleCities = [
    'Mumbai',
    'Delhi',
    'Bangalore',
    'Hyderabad',
    'Ahmedabad',
    'Chennai',
    'Kolkata',
    'Surat',
    'Pune',
    'Jaipur',
    'Lucknow',
    'Kanpur',
    'Nagpur',
    'Indore',
    'Thane'
  ];
  final List<String> sampleImages = [
    'https://randomuser.me/api/portraits/men/1.jpg',
    'https://randomuser.me/api/portraits/women/1.jpg',
    'https://randomuser.me/api/portraits/men/2.jpg',
    'https://randomuser.me/api/portraits/women/2.jpg',
    'https://randomuser.me/api/portraits/men/3.jpg',
    'https://randomuser.me/api/portraits/women/3.jpg',
    'https://randomuser.me/api/portraits/men/4.jpg',
    'https://randomuser.me/api/portraits/women/4.jpg',
    'https://randomuser.me/api/portraits/men/5.jpg',
    'https://randomuser.me/api/portraits/women/5.jpg'
  ];

  final int itemsPerPage = 20;
  int currentMax = 0;
  bool isLoading = false;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    generateUsers();
    loadInitialUsers();
    pagination();
  }

  void generateUsers() {
    allUsers = List.generate(
      50,
      (index) => User(
        name: sampleNames[Random().nextInt(sampleNames.length)],
        phoneNumber: '123456${Random().nextInt(1000)}',
        city: sampleCities[Random().nextInt(sampleCities.length)],
        imageUrl: sampleImages[Random().nextInt(sampleImages.length)],
        rupee: Random().nextInt(101),
      ),
    );
    update();
  }

  void loadInitialUsers() {
    displayedUsers = allUsers.take(itemsPerPage).toList();
    currentMax = displayedUsers.length;
    update();
  }

  void loadMore() {
    if (isLoading || currentMax >= allUsers.length) return;

    isLoading = true;
    update();

    Future.delayed(const Duration(seconds: 2), () {
      int nextMax = currentMax + itemsPerPage;
      if (nextMax > allUsers.length) {
        nextMax = allUsers.length;
      }
      displayedUsers.addAll(allUsers.getRange(currentMax, nextMax));
      currentMax = nextMax;
      isLoading = false;
      update();
    });
  }

  void pagination() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        loadMore();
      }
    });
  }

  void filterUsers(String query) {
    final filteredUsers = allUsers.where((user) {
      final nameLower = user.name?.toLowerCase();
      final phoneLower = user.phoneNumber?.toLowerCase();
      final cityLower = user.city?.toLowerCase();
      final searchLower = query.toLowerCase();

      return nameLower!.contains(searchLower) ||
          phoneLower!.contains(searchLower) ||
          cityLower!.contains(searchLower);
    }).toList();

    displayedUsers = filteredUsers.take(itemsPerPage).toList();
    currentMax = itemsPerPage;
    update();
  }

  void updateUserRupee(int index, int newRupee) {
    displayedUsers[index].rupee = newRupee;
    allUsers[index].rupee = newRupee;
    update();
  }
}
