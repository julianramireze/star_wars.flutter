import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:star_wars/services/stability_ai.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'dart:io';
import 'package:star_wars/constants/colors.dart' as AppColors;
import 'package:flutter/foundation.dart';
import 'package:star_wars/widgets/custom_button.dart';

class StabilityAiImage extends HookWidget {
  final String prompt;
  final String name;
  final double width;
  final double height;
  final BoxFit fit;
  final bool isCircle;
  final BoxDecoration? boxDecoration;
  final EdgeInsets padding;
  final EdgeInsets margin;

  StabilityAiImage({
    required this.prompt,
    required this.name,
    this.width = 100,
    this.height = 100,
    this.fit = BoxFit.cover,
    this.isCircle = false,
    this.boxDecoration,
    this.padding = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.all(0),
  });

  @override
  Widget build(BuildContext context) {
    final retryImage = useState(0);
    final loadingPercentageImage = useState(0.0);
    final imageFile = useState("");
    final loadingImage = useState(true);
    final errorImage = useState(false);

    useEffect(() {
      if (imageFile.value.isEmpty) {
        loadingImage.value = true;
        errorImage.value = false;
        imageFile.value = "";
        loadingPercentageImage.value = 0.0;

        (() async {
          if (imageFile.value.isEmpty) {
            final tempDirectory = await getTemporaryDirectory();
            final hash = name.toLowerCase().trim().hashCode;
            final file = File("${tempDirectory.path}/images/$hash.png");
            if (file.existsSync()) {
              imageFile.value = file.path;
            } else {
              try {
                Response response =
                    await StabilityAIService.getStabilityAIResponse(
                        text: prompt,
                        onReceiveProgress: (int received, int total) {
                          if (total != -1) {
                            loadingPercentageImage.value =
                                (received / total * 100);
                          }
                        });

                if (response.statusCode == 200) {
                  final bytes = response.data;
                  await file.create(recursive: true);
                  await file.writeAsBytes(bytes);
                  imageFile.value = file.path;
                }
              } on DioError catch (error) {
                if (kDebugMode) {
                  print(error);
                }

                errorImage.value = true;
              }
            }
            loadingImage.value = false;
          }
        }());
      }

      return;
    }, [retryImage.value]);

    return CustomButton(
      borderRadius:
          isCircle ? BorderRadius.circular(100) : BorderRadius.circular(0),
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      onTap: () {
        retryImage.value = retryImage.value + 1;
      },
      enabled: errorImage.value,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        margin: margin,
        decoration: boxDecoration ??
            BoxDecoration(
              color: AppColors.Colors.gray,
              borderRadius: isCircle
                  ? BorderRadius.circular(100)
                  : BorderRadius.circular(0),
            ),
        child: loadingImage.value
            ? Center(
                child: Text(
                    "${loadingPercentageImage.value.toStringAsFixed(1)}%",
                    maxLines: 1,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.surface,
                        fontSize: 10,
                        fontWeight: FontWeight.normal)))
            : errorImage.value
                ? Icon(Icons.refresh,
                    color: Theme.of(context).colorScheme.onSurface, size: 30)
                : ClipRRect(
                    borderRadius: isCircle
                        ? BorderRadius.circular(100)
                        : BorderRadius.circular(0),
                    child: Image.file(
                      File(imageFile.value),
                      fit: fit,
                    ),
                  ),
      ),
    );
  }
}