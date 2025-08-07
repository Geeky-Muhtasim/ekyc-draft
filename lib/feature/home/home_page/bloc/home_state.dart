import 'package:flutter/material.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<HomeMenuItem> menuItems;

  HomeLoadedState({required this.menuItems});
}

class HomeErrorState extends HomeState {
  final String message;

  HomeErrorState({required this.message});
}

class HomeMenuItem {
  final String key;
  final String title;
  final IconData icon;

  HomeMenuItem({
    required this.key,
    required this.title,
    required this.icon,
  });
}

class HomeSelectedState extends HomeState {
  final String selectedServiceTypeId;

  HomeSelectedState({required this.selectedServiceTypeId});
}
