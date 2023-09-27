import 'package:artivatic_test/provider/HomeProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// This is text field widget for search
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
          onPressed: () {},
          icon: const Icon(
            Icons.search,
            color: Colors.black,
          ),
        ),
        suffixIcon: homeProvider.showClose
            ? IconButton(
                onPressed: () {
                  homeProvider.clearTextField();
                  homeProvider.updateStatus();
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              )
            : null,
      ),
    ),
  );
}

// This is list view widget to show data
Widget dataList(BuildContext context, HomeProvider homeProvider) {
  return homeProvider.rows == null
      ? const CircularProgressIndicator()
      : Expanded(
          child: ListView.separated(
            itemCount: homeProvider.rows!.length,
            separatorBuilder: (context, index) {
              return Divider(
                height: 1,
                color: Colors.grey.shade400,
              );
            },
            itemBuilder: (context, index) {
              return Row(
                children: [
                  loadImageData(homeProvider.rows![index].imageHref == null ? "" : homeProvider.rows![index].imageHref.toString()),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        showText(homeProvider.rows![index].title == null ? "" : "Title: ${homeProvider.rows![index].title}", 18, FontWeight.w600),
                        const SizedBox(height: 5),
                        showText(homeProvider.rows![index].description == null ? "" : "Description: ${homeProvider.rows![index].description}", 14, FontWeight.w400),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        );
}

// This is image view widget to show image
Widget loadImageData(String image) {
  return CachedNetworkImage(
    imageUrl: image,
    width: 100,
    progressIndicatorBuilder: (context, url, downloadProgress) {
      return CircularProgressIndicator(
        strokeWidth: 2,
        value: downloadProgress.progress,
      );
    },
    errorWidget: (context, url, error) {
      return const Icon(Icons.error);
    },
  );
}

// This is text widget to show text for title and description
Widget showText(String message, double fontSize, FontWeight fontWeight) {
  return Text(
    message,
    style: TextStyle(
      color: Colors.black,
      fontSize: fontSize,
      fontWeight: fontWeight,
    ),
  );
}
