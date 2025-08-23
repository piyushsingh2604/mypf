import 'package:flutter/material.dart';
import 'package:mypf/models/project_model.dart';
import 'package:mypf/utils/web_colors.dart';

class WhatsAppImageGrid extends StatelessWidget {
  final List<ImageModel> images;
  final List<ChipModel> chips;
  final String des;
  final String projectName;

  const WhatsAppImageGrid({
    super.key,
    required this.images,
    required this.projectName,
    required this.chips,
    required this.des,
  });

  @override
  Widget build(BuildContext context) {
    int total = images.length;
    int displayCount = total > 4 ? 4 : total;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 250,
          child: Text(
            projectName,
            style: TextStyle(
              color: WebColors.textColor,
              fontWeight: FontWeight.bold,
              fontSize: 21,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: 9),
        Container(
          width: 250,
          padding: const EdgeInsets.only(
              bottom: 15, left: 10, right: 10, top: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: WebColors.buttonColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 250,
                width: 250,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: displayCount,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                  ),
                  itemBuilder: (context, index) {
                    final imageUrl = images[index].name; // ✅ FIX

                    if (index == 3 && total > 4) {
                      return GestureDetector(
                        onTap: () => _openGallery(context, index),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              color: Colors.black45,
                              child: Center(
                                child: Text(
                                  "+${total - 4}",
                                  style: const TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    // Normal image
                    return GestureDetector(
                      onTap: () => _openGallery(context, index),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 15),
              LayoutBuilder(
                builder: (context, constraints) {
                  int count = constraints.maxWidth > 200 ? 2 : 1;

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: chips.length,
                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: count,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 3,
                    ),
                    itemBuilder: (context, index) {
                      return chip(text: chips[index].name);
                    },
                  );
                },
              ),
              const SizedBox(height: 9),
              Text(
                des,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(89, 255, 255, 255),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _openGallery(BuildContext context, int startIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FullGallery(
          images: images.map((e) => e.name).toList(), // ✅ FIX
          initialIndex: startIndex,
        ),
      ),
    );
  }

  Widget chip({required String text}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: WebColors.buttonColor),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: WebColors.textColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class FullGallery extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const FullGallery({
    super.key,
    required this.images,
    required this.initialIndex,
  });

  @override
  State<FullGallery> createState() => _FullGalleryState();
}

class _FullGalleryState extends State<FullGallery> {
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: widget.initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black),
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              return InteractiveViewer(
                child: Center(
                  child: Image.network(widget.images[index]),
                ),
              );
            },
          ),
          // Left button
          Positioned(
            left: 10,
            top: MediaQuery.of(context).size.height / 2 - 30,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                if (_controller.page! > 0) {
                  _controller.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
            ),
          ),
          // Right button
          Positioned(
            right: 10,
            top: MediaQuery.of(context).size.height / 2 - 30,
            child: IconButton(
              icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
              onPressed: () {
                if (_controller.page! < widget.images.length - 1) {
                  _controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
