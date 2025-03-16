import 'package:flutter/material.dart';

class AdminAnnouncementBanner extends StatefulWidget {
  @override
  _AdminAnnouncementBannerState createState() =>
      _AdminAnnouncementBannerState();
}

class _AdminAnnouncementBannerState extends State<AdminAnnouncementBanner> {
  bool isVisible = true; // Controls visibility of banner

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return SizedBox.shrink(); // Hide if dismissed

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.redAccent, Colors.deepOrange],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "🚀 Boost Your Sales with Promotions!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Get featured on FixitBhaii’s homepage and attract more customers. Limited-time offer!",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to detailed promotions page
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    child: Text(
                      "View More",
                      style: TextStyle(
                          color: Colors.redAccent, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.white70),
              onPressed: () {
                setState(() {
                  isVisible = false; // Hide banner on close
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
