import 'dart:io';
import 'package:apps_daftar_hadir/core/utils/color_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';

class FormImage extends StatelessWidget {
  final File? image;
  final Uint8List? webImage;
  final Function()? actionCamera;
  final Function()? actionGallery;
  final Function(File)? onSelectFile;
  final String? title;
  final String? subTitle;
  final bool buttonFile;
  const FormImage({
    super.key,
    this.image,
    this.actionCamera,
    this.actionGallery,
    this.title,
    this.subTitle,
    this.buttonFile = false,
    this.onSelectFile,
    this.webImage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BottomSheetImage().showImagePicker(
          context,
          title: 'Ambil Foto melalui',
          actionCamera: actionCamera!,
          actionGallery: actionGallery!,
          hideButton: buttonFile,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: ColorPallate.whiteColor,
          border: RDottedLineBorder.all(
            color: ColorPallate.primarycolor,
            width: 1,
            dottedSpace: 10,
            dottedLength: 10,
          ),
        ),
        child: (image != null || webImage != null)
            ? webImage != null
                ? Image.memory(
                    webImage!,
                    fit: BoxFit.cover,
                  )
                : Image.file(
                    image!,
                    fit: BoxFit.cover,
                  )
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.file_present_outlined,
                      color: ColorPallate.primarycolor,
                      size: 50,
                    ),
                    Text(
                      title ?? "",
                      style: GoogleFonts.inter(
                        color: ColorPallate.black70color,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      subTitle ?? "",
                      style: GoogleFonts.inter(
                        color: ColorPallate.black50color,
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class FormImageCircle extends StatelessWidget {
  final File? image;
  final Uint8List? webImage;
  final Function()? actionCamera;
  final Function()? actionGallery;
  final double? sizeImage;
  const FormImageCircle({
    super.key,
    this.image,
    this.actionCamera,
    this.actionGallery,
    this.sizeImage,
    this.webImage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BottomSheetImage().showImagePicker(
          context,
          title: 'Ambil Foto melalui',
          actionCamera: actionCamera!,
          actionGallery: actionGallery!,
          hideButton: false,
        );
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: const DecorationImage(
                image:
                    NetworkImage("https://mm.widyatama.ac.id/wp-content/uploads/2020/08/dummy-profile-pic-male1.jpg"),
                fit: BoxFit.cover,
              ),
              border: RDottedLineBorder.all(
                color: ColorPallate.primarycolor,
                width: 2.2,
                dottedSpace: 6,
                dottedLength: 6,
              ),
            ),
            child: Builder(
              builder: (context) {
                if (image != null || webImage != null) {
                  return Builder(
                    builder: (context) {
                      if (kIsWeb) {
                        return CircleAvatar(
                          backgroundImage: MemoryImage(webImage!),
                          radius: 62,
                        );
                      } else {
                        return CircleAvatar(
                          backgroundImage: FileImage(image!),
                          radius: 62,
                        );
                      }
                    },
                  );
                } else {
                  return const CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://mm.widyatama.ac.id/wp-content/uploads/2020/08/dummy-profile-pic-male1.jpg"),
                    radius: 62,
                  );
                }
              },
            ),
          ),
          Positioned(
            bottom: 10,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(color: ColorPallate.greyBGcolor, width: 1),
                  color: ColorPallate.whiteColor,
                  shape: BoxShape.circle),
              child: const Icon(
                size: 18,
                Icons.camera_alt,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomSheetImage {
  showImagePicker(
    BuildContext context, {
    required VoidCallback actionCamera,
    required VoidCallback actionGallery,
    required String title,
    required bool hideButton,
  }) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 160,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.nunitoSans(
                        color: ColorPallate.black90color,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.close,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15, bottom: 20),
                width: MediaQuery.of(context).size.width,
                height: 0.7,
                color: Colors.grey[300],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: actionCamera,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorPallate.primarycolor,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.camera_alt,
                                size: 24,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Camera',
                            style: GoogleFonts.nunitoSans(
                              color: ColorPallate.black90color,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: actionGallery,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorPallate.primarycolor,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.image,
                                size: 24,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Galeri',
                            style: GoogleFonts.nunitoSans(
                              color: ColorPallate.black90color,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
