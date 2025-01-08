import 'package:app_web/controller/category_controller.dart';
import 'package:app_web/controller/subcategory_controller.dart';
import 'package:app_web/views/sidebar_screens/subcategory_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../models/category.dart';

class SubcategoryScreen extends StatefulWidget {
  static const String id = "subCategoriesScreen";
  const SubcategoryScreen({super.key});

  @override
  State<SubcategoryScreen> createState() => _SubcategoryScreenState();
}

class _SubcategoryScreenState extends State<SubcategoryScreen> {
  late Future<List<Category>> futureCategories;
  Category? selectedCategory;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SubcategoryController subcategoryController = SubcategoryController();
  late String name;
  dynamic _image;

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
  void initState() {
    futureCategories = CategoryController().loadCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(4.0),
              child: Text(
                "Subcategories",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            FutureBuilder(
                future: futureCategories,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Error: ${snapshot.error}"),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text("Subcategories not found"),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: DropdownButton<Category>(
                          value: selectedCategory,
                          hint: const Text("Select Category"),
                          items: snapshot.data!.map((Category category) {
                            return DropdownMenuItem(
                                value: category, child: Text(category.name));
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedCategory = value;
                            });
                          }),
                    );
                  }
                }),
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
                              "Subcategory Image",
                            ),
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 200,
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                      validator: (value) {
                        if (value!.isNotEmpty) {
                          return null;
                        } else {
                          return 'Please enter Subcategory name.';
                        }
                      },
                      decoration: const InputDecoration(
                          labelText: "Enter Subcategory name"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          subcategoryController.uploadSubcategory(
                              categoryId: selectedCategory!.id,
                              categoryName: selectedCategory!.name,
                              pickedImage: _image,
                              subCategoryName: name,
                              context: context);
                        }
                        print(selectedCategory!.name);
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
                ),
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),

            const SubcategoryWidget(),
          ],
        ),
      ),
    );
  }
}
