import 'package:flutter/material.dart';
import 'package:flutter_web_ptb/app_router.dart';
import 'package:flutter_web_ptb/views/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutter_web_ptb/views/widgets/portal_master_layout/sidebar.dart';

final sidebarMenuConfigs = [
  SidebarMenuConfig(
    uri: RouteUri.dashboard,
    icon: Icons.dashboard_rounded,
    title: (context) => 'Dashboard',
  ),
  SidebarMenuConfig(
    uri: RouteUri.site,
    icon: Icons.edit_note_rounded,
    title: (context) => 'Site',
  ),
  SidebarMenuConfig(
    uri: RouteUri.employee,
    icon: Icons.people,
    title: (context) => 'Employee',
  ),
  SidebarMenuConfig(
    uri: RouteUri.task,
    icon: Icons.task,
    title: (context) => 'Task',
  ),
];

const localeMenuConfigs = [
  LocaleMenuConfig(
    languageCode: 'en',
    name: 'English',
  ),
  LocaleMenuConfig(
    languageCode: 'zh',
    scriptCode: 'Hans',
    name: '中文 (简体)',
  ),
  LocaleMenuConfig(
    languageCode: 'zh',
    scriptCode: 'Hant',
    name: '中文 (繁體)',
  ),
];