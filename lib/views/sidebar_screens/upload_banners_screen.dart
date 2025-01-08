import 'package:app_web/controller/banner_controller.dart';
import 'package:app_web/views/sidebar_screens/banner_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class UploadBannersScreen extends StatefulWidget {
  static const String id = "\banners-screen";
  const UploadBannersScreen({super.key});

  @override
  State<UploadBannersScreen> createState() => _UploadBannersScreenState();
}

class _UploadBannersScreenState extends State<UploadBannersScreen> {
  dynamic _image;
  final BannerController _bannerController = BannerController();

  pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        _image = result.files.first.bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: const Text(
            "Banner",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 36, letterSpacing: 1.7),
          ),
        ),
        const Divider(
          color: Colors.grey,
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: _image != null
                    ? Image.memory(_image)
                    : const Center(
                        child: Text(
                          "Banner Image",
                        ),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                  onPressed: () async {
                    await _bannerController.uploadBanner(
                        pickedImage: _image, context: context);
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              onPressed: () {
                pickImage();
              },
              child: const Text(
                "Pick Image",
                style: TextStyle(color: Colors.white),
              )),
        ),
        const Divider(
          color: Colors.grey,
        ),
        const BannerWidget(),
      ],
    );
  }
}
