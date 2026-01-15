import 'package:flutter/material.dart';
import '../core/constants/colors.dart';

class CustomBanner extends StatelessWidget {
  final List<String> imageUrls;
  
  const CustomBanner({
    super.key,
    required this.imageUrls,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: PageView.builder(
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.highlightColor, // Placeholder color
              image: DecorationImage(
                image: imageUrls[index].startsWith('http') 
                  ? NetworkImage(imageUrls[index]) as ImageProvider
                  : AssetImage(imageUrls[index]),
                fit: BoxFit.fill,
              ),
            ),
             child: imageUrls[index].isEmpty 
                 ? const Center(child: Text("Promotional Banner", style: TextStyle(fontWeight: FontWeight.bold))) 
                 : null,
          );
        },
      ),
    );
  }
}
