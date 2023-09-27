

// This is text field widget for search
import 'package:artivatic_test/provider/HomeProvider.dart';
import 'package:flutter/material.dart';

Widget searchBox(BuildContext context, HomeProvider homeProvider) {
  return Container(
    margin: const EdgeInsets.all(10),
    child: TextFormField(
      controller: homeProvider.controller,
      cursorColor: Colors.black,
      onChanged: (value) {
        homeProvider.updateStatus();
        homeProvider.searchTitle(value);
      },
      decoration: InputDecoration(
        prefixIcon: IconButton(
          onPressed: () {

          },
          icon: const Icon(
            Icons.search,
            color: Colors.black,
          ),
        ),
        suffixIcon: homeProvider.showClose ? IconButton(
          onPressed: () {
            homeProvider.clearTextField();
            homeProvider.updateStatus();
          },
          icon: const Icon(
            Icons.close,
            color: Colors.black,
          ),
        ) : null,
      ),
    ),
  );
}