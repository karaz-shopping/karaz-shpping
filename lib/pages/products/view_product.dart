import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/pages/products/components/custom_add_card.dart';

class ViewProduct extends StatefulWidget {
  const ViewProduct({super.key});

  @override
  State<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Product'),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Wrap(
            children: const [
              CustomAdsCard(),
              CustomAdsCard(),
            ],
          ),
        ),
      ),
    );
  }
}
