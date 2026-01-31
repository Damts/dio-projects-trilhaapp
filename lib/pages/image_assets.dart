import 'package:flutter/material.dart';
import 'package:trilhaapp/shared/widgets/app_images.dart';

class ImageAssetsPage extends StatefulWidget {
  const ImageAssetsPage({super.key});

  @override
  State<ImageAssetsPage> createState() => _ImageAssetsPageState();
}

class _ImageAssetsPageState extends State<ImageAssetsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          AppImages.stew,
          height: 100,
        ),
        Image.asset(
          AppImages.colin,
          height: 100,
        ),
        Image.asset(
          AppImages.erenMikasa,
          height: 100,
        ),
        Image.asset(
          AppImages.momoKen,
          height: 100,
        ),
        Image.asset(
          AppImages.luminosity,
          // width: double.infinity,
          height: 100,
        ),
        Image.asset(
          AppImages.lpu,
          height: 100,
        ),
      ],
    );
  }
}