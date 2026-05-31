import 'package:flutter/material.dart';
import 'package:mypf/utils/web_colors.dart';
import 'package:mypf/models/project_model.dart';

class ProjectCard extends StatefulWidget {
  final List<ImageModel> images;
  final List<ChipModel> chips;
  final String des;
  final String projectName;

  const ProjectCard({
    super.key,
    required this.images,
    required this.projectName,
    required this.chips,
    required this.des,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    int total = widget.images.length;
    int display = total > 4 ? 4 : total;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        transform: _hovered
            ? (Matrix4.identity() * Matrix4.translationValues(0, -8, 0))
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: WebColors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hovered
                ? WebColors.primary.withValues(alpha: 0.3)
                : WebColors.glass,
          ),
          boxShadow: _hovered
              ? [BoxShadow(
                  color: WebColors.primary.withValues(alpha: 0.1),
                  blurRadius: 32,
                  offset: const Offset(0, 12),
                )]
              : [],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.projectName,
              style: TextStyle(
                color: _hovered ? WebColors.primary : WebColors.text,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 14),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 220,
                width: double.infinity,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: display,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                  ),
                  itemBuilder: (context, i) {
                    final url = widget.images[i].name;
                    if (i == 3 && total > 4) {
                      return GestureDetector(
                        onTap: () => _openGallery(context, i),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.network(url, fit: BoxFit.cover),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Center(
                                child: Text(
                                  "+${total - 4}",
                                  style: const TextStyle(
                                    fontSize: 20, color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return GestureDetector(
                      onTap: () => _openGallery(context, i),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.network(url, fit: BoxFit.cover),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: widget.chips.map((c) => _chip(c.name)).toList(),
            ),
            const SizedBox(height: 10),
            Text(
              widget.des,
              style: TextStyle(
                fontSize: 12,
                height: 1.5,
                color: WebColors.textMuted.withValues(alpha: 0.8),
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _chip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: WebColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: WebColors.primary,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  void _openGallery(BuildContext context, int start) {
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => FullGallery(
        images: widget.images.map((e) => e.name).toList(),
        initialIndex: start,
      ),
    ));
  }
}

class FullGallery extends StatefulWidget {
  final List<String> images;
  final int initialIndex;
  const FullGallery({super.key, required this.images, required this.initialIndex});
  @override
  State<FullGallery> createState() => _FullGalleryState();
}

class _FullGalleryState extends State<FullGallery> {
  late PageController _c;
  @override
  void initState() {
    super.initState();
    _c = PageController(initialPage: widget.initialIndex);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black, elevation: 0),
      body: Stack(
        children: [
          PageView.builder(
            controller: _c,
            itemCount: widget.images.length,
            itemBuilder: (context, i) => InteractiveViewer(
              child: Center(child: Image.network(widget.images[i])),
            ),
          ),
          Positioned(
            left: 10, top: MediaQuery.of(context).size.height / 2 - 30,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                if (_c.page! > 0) _c.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
              },
            ),
          ),
          Positioned(
            right: 10, top: MediaQuery.of(context).size.height / 2 - 30,
            child: IconButton(
              icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
              onPressed: () {
                if (_c.page! < widget.images.length - 1) _c.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
              },
            ),
          ),
        ],
      ),
    );
  }
}