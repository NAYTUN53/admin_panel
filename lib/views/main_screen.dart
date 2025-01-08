import 'package:app_web/views/sidebar_screens/buyers_screen.dart';
import 'package:app_web/views/sidebar_screens/categories_screen.dart';
import 'package:app_web/views/sidebar_screens/orders_screen.dart';
import 'package:app_web/views/sidebar_screens/products_screen.dart';
import 'package:app_web/views/sidebar_screens/subcategory_screen.dart';
import 'package:app_web/views/sidebar_screens/upload_banners_screen.dart';
import 'package:app_web/views/sidebar_screens/vendors_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _selectedScreen = const VendorsScreen();

  screenSelector(item) {
    switch (item.route) {
      case VendorsScreen.id:
        setState(() {
          _selectedScreen = const VendorsScreen();
        });
        break;

      case BuyersScreen.id:
        setState(() {
          _selectedScreen = const BuyersScreen();
        });
        break;

      case OrdersScreen.id:
        setState(() {
          _selectedScreen = const OrdersScreen();
        });
        break;

      case CategoriesScreen.id:
        setState(() {
          _selectedScreen = const CategoriesScreen();
        });
        break;

      case SubcategoryScreen.id:
        setState(() {
          _selectedScreen = const SubcategoryScreen();
        });
        break;

      case UploadBannersScreen.id:
        setState(() {
          _selectedScreen = const UploadBannersScreen();
        });
        break;

      case ProductsScreen.id:
        setState(() {
          _selectedScreen = const ProductsScreen();
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Management",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _selectedScreen,
      sideBar: SideBar(
        header: Container(
          width: double.infinity,
          height: 50,
          decoration: const BoxDecoration(
            color: Colors.black54,
          ),
          child: const Center(
            child: Text(
              "Multi Vendors Admin",
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                  letterSpacing: 1.7,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        items: const [
          AdminMenuItem(
              title: "Vendors",
              route: VendorsScreen.id,
              icon: Icons.person_3_outlined),
          AdminMenuItem(
              title: "Buyers", route: BuyersScreen.id, icon: Icons.person),
          AdminMenuItem(
              title: "Orders",
              route: OrdersScreen.id,
              icon: Icons.shopping_cart),
          AdminMenuItem(
              title: "Categories",
              route: CategoriesScreen.id,
              icon: Icons.category),
          AdminMenuItem(
              title: "Subcategories",
              route: SubcategoryScreen.id,
              icon: Icons.category_outlined),
          AdminMenuItem(
              title: "Upload Banners",
              route: UploadBannersScreen.id,
              icon: Icons.upload),
          AdminMenuItem(
              title: "Products", route: ProductsScreen.id, icon: Icons.store),
        ],
        selectedRoute: VendorsScreen.id,
        onSelected: (item) {
          screenSelector(item);
        },
      ),
    );
  }
}
