import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:trilhaapp/shared/widgets/app_images.dart';

class CropAspectRatioPresetCustom implements CropAspectRatioPresetData {
  @override
  (int, int)? get data => (2, 3);

  @override
  String get name => '2x3 (customized)';
}

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final ScrollController _scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();
  String? _path;
  String? _name;
  XFile? image;
  XFile? photo;

  List<String> listaImagens = [];

  @override
  void initState() {
    super.initState();
    _carregarImagens();
  }

  Future<void> _carregarImagens() async {
    // Pegar Imagens da galeria para mostrar na tela
    // final directory = await path_provider.getApplicationDocumentsDirectory();
    // final List<FileSystemEntity> files = directory.listSync();
    // setState(() {
    //   listaImagens = files.map((file) => file.path).toList();
    // });

    // Por hora configurado pegando as imagens em assets
    for (String image in AppImages.listaImagens) {
      listaImagens.add(image);
    }
  }

  Future<void> cropImage(XFile imageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Recortar Imagem',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPresetCustom(),
          ],
        ),
        IOSUiSettings(
          title: 'Recortar Image',
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPresetCustom(), // IMPORTANT: iOS supports only one custom aspect ratio in preset list
          ],
        ),
      ],
    );
    if (croppedFile != null) {
      await GallerySaver.saveImage(croppedFile.path);
      photo = XFile(croppedFile.path);
      setState(() { });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Camera'),
          backgroundColor: Colors.blue,
          elevation: 10,
        ),
        body: Column(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.blue,
                  )
                ),
                child: TextButton(
                  onPressed: () async {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext bc) {
                        return SafeArea(
                          child: Wrap(
                            children: [
                              ListTile(
                                leading: FaIcon(FontAwesomeIcons.camera),
                                title: Text("Camera"),
                                onTap: () async {
                                  photo = await _picker.pickImage(source: ImageSource.camera);
                                  if (photo != null) {

                                    _path = (await path_provider.getApplicationDocumentsDirectory()).path;
                                    _name = basename(photo!.path);
                                    final photoPath = "$_path/$_name";

                                    await photo!.saveTo(photoPath);
                                    cropImage(photo!);
                                  }

                                  setState(() {
                                    // image = photo;
                                  });
                                  if (context.mounted) Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                leading: FaIcon(FontAwesomeIcons.image),
                                title: Text("Galeria"),
                                onTap: () async {
                                  photo = await _picker.pickImage(source: ImageSource.gallery);
                                  setState(() {
                                    // image = photo;
                                  });
                                  if (context.mounted) Navigator.pop(context);
                                  cropImage(photo!);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }, 
                  child: Text("Abrir camera"),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Carregando as fotos em list view
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: listaImagens.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      children: [
                        // Carregando a foto que tirou na camera
                        if (photo != null) ...[
                          Image.file(File(photo!.path)),
                        ] else ...[
                          Container(),
                        ],
                        const SizedBox(height: 24),
                        Image.asset(listaImagens[index], fit: BoxFit.contain),
                      ],
                    )
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}