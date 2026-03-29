import 'package:flutter/material.dart';

class UserProfile {
  final int id;
  final String name;
  final int age;
  final String location;
  final String profession;
  final String bio;
  final String salary;
  final Color avatarColor;
  final List<String> imageUrls;
  bool favorite;
  bool blocked;

  UserProfile({
    required this.id,
    required this.name,
    required this.age,
    required this.location,
    required this.profession,
    required this.bio,
    required this.salary,
    required this.avatarColor,
    required this.imageUrls,
    this.favorite = false,
    this.blocked = false,
  });

  String get initials {
    final parts = name.split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}';
    return name[0];
  }
}
