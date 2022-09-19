import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SettingState extends Equatable {
  const SettingState({required this.themes});
  final ThemeData themes;
  @override
  List<Object> get props => [themes];
}
