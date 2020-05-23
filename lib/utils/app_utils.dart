import 'dart:io';

import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF171B1E);
const Color secondaryColor = Color(0xFF1B232F);
const Color tertiaryColor = Color(0xFF243145);
const Color color_for_active = Color(0xFFFFF492);
const Color color_for_confirmed = Color(0xFFFFC814);
const Color color_for_recovered = Color(0xFF00CC99);
const Color color_for_deaths = Color(0xFFF76353);
const Color appBar_icons_text_color = Color(0xFFFFC814);
const Color linear_gradient_color_one = Color(0xF0F00f14);
const Color linear_gradient_color_two = Color(0xF0F0ff40);
const Color animated_color = Color(0xF0F0ff40);
const Color cPaint_color = Color(0xF0F0ff40);
const Color linear_gradient_four = Color(0xF0F0ff40);
const Color linear_gradient_three = Color(0xF0F0ff40);

const Color home_drawer_bg_color = Color(0xF0142850);
const Color home_drawer_title_color = Color(0xF0ff5200);
const Color home_drawer_img_shadow_color = Color(0xF0120136);
const Color home_drawer_selected_cursor_color = Color(0xF0ff5200);
const Color home_drawer_unselected_cursor_color = Color(0xF0035aa6);
const Color home_drawer_selected_colo_highlight = Color(0xF0f6f578);


const Color appBar_scrolldown_shadow_color = Color(0xF0f6f578);
const Color appBar_title_color = Color(0xF0f7f7f7);
const Color appBar_icons_color = Color(0xF0ffd31d);
const double appBar_title_size = 16;
const double appBar_title_left_padding = 58.0;

const Color home_screen_boxes_title_color = Color(0xF03f3f44);
const Color home_screen_boxes_subtitle_color = Color(0xF000005c);
const Color home_screen_boxes_numbers_color = Color(0xF0d9455f);
const Color home_screen_boxes_numbers_subtext_color = Color(0xF06f0000);
const Color home_screen_boxes_top_imgBG_circle_color = Color(0xF0faf2f2);

List countries;
List<String> dateOfDeath;
List<String> deathsOnThatDay;
var confirmed, recovered, deaths, lastUpdate;

 Future<bool> checkInternetConnectivity() async {
    bool isConnected;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      }
    } on SocketException catch (_) {
      isConnected = false;
    }
    return isConnected;
  }