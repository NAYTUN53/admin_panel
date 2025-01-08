import 'package:app_web/controller/subcategory_controller.dart';
import 'package:app_web/models/subcategory.dart';
import 'package:flutter/material.dart';

class SubcategoryWidget extends StatefulWidget {
  const SubcategoryWidget({super.key});

  @override
  State<SubcategoryWidget> createState() => _SubcategoryWidgetState();
}

class _SubcategoryWidgetState extends State<SubcategoryWidget> {
  late Future<List<Subcategory>> futureCategory;

  @override
  void initState() {
    futureCategory = SubcategoryController().loadSubcategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureCategory,
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
            final subcategories = snapshot.data!;
            return GridView.builder(
                itemCount: subcategories.length,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6, mainAxisSpacing: 8, crossAxisSpacing: 8),
                itemBuilder: (context, index) {
                  final subcategory = subcategories[index];
                  return Column(
                    children: [
                      Image.network(
                        subcategory.image,
                        height: 100,
                        width: 100,
                      ),
                      Text(subcategory.subCategoryName),
                    ],
                  );
                });
          }
        });
  }
}
