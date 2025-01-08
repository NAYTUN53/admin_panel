import 'dart:convert';

import 'package:app_web/global_variable.dart';
import 'package:app_web/models/category.dart';
import 'package:app_web/services/manage_http_response.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;

class CategoryController {
  uploadCategory(
      {required dynamic pickedImage,
      required dynamic pickBanner,
      required String name,
      required context}) async {
    try {
      final cloudinary = CloudinaryPublic("dymyqeyyw", "t2mdxedr");

      // Upload image
      CloudinaryResponse imageResponse = await cloudinary.uploadFile(
          CloudinaryFile.fromBytesData(pickedImage,
              identifier: 'pickedImage', folder: 'categoryImages'));
      String image = imageResponse.secureUrl;

      CloudinaryResponse bannerResponse = await cloudinary.uploadFile(
          CloudinaryFile.fromBytesData(pickBanner,
              identifier: "pickedBanner", folder: 'categoryImages'));

      String banner = bannerResponse.secureUrl;

      Category category =
          Category(id: '', name: name, image: image, banner: banner);

      http.Response response = await http.post(Uri.parse("$uri/api/categories"),
          body: category.toJson(),
          headers: <String, String>{
            "Content-Type": 'application/json; charset=UTF-8'
          });

      manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, "Uploaded category");
          });
    } catch (e) {
      print('Error uploading to cloudinary');
    }
  }

  // Load the uploaded categories
  Future<List<Category>> loadCategories() async {
    try {
      http.Response response = await http.get(Uri.parse("$uri/api/categories"),
          headers: {"Content-Type": "application/json; charset=UTF-8"});
      print(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<Category> categories =
            data.map((category) => Category.fromJson(category)).toList();
        return categories;
      } else {
        throw Exception("Failed to load categories.");
      }
    } catch (e) {
      throw Exception("Error loading categories:  $e");
    }
  }
}
