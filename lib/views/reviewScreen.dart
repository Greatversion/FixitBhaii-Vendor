import 'package:auto_route/auto_route.dart';
import 'package:fixitbhaiivendor/utils/themes/app.colors.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CustomerReviewsScreen extends StatefulWidget {
  const CustomerReviewsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CustomerReviewsScreenState createState() => _CustomerReviewsScreenState();
}

class _CustomerReviewsScreenState extends State<CustomerReviewsScreen> {
  int _selectedFilter = 0; // 0: All, 1-5: Star Ratings

  final List<Map<String, dynamic>> reviews = [
    {
      "customerName": "Amit Sharma",
      "rating": 5,
      "review":
          "Great product! Looks brand new and works perfectly. Totally worth it.",
      "date": "Feb 15, 2025",
      "images": ["assets/images/nn.jpeg"],
      "reply": "",
    },
    {
      "customerName": "Neha Gupta",
      "rating": 4,
      "review": "Good condition, but packaging could have been better.",
      "date": "Feb 12, 2025",
      "images": [
        "assets/images/nn.jpeg",
      ],
      "reply": "Thanks for your feedback! We'll improve our packaging.",
    },
    {
      "customerName": "Rajesh Verma",
      "rating": 3,
      "review": "Decent product, but minor scratches visible.",
      "date": "Feb 10, 2025",
      "images": [
        "assets/images/nn.jpeg",
        "assets/images/nn.jpeg",
      ],
      "reply": "",
    },
  ];

  void _replyToReview(int index, String reply) {
    setState(() {
      reviews[index]["reply"] = reply;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        // backgroundColor: AppColors.textPrimary,
        title: Text(
          "Customer Reviews",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRatingFilter(),
            SizedBox(height: 10),

            // Reviews List
            Expanded(
              child: ListView.builder(
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  final review = reviews[index];

                  // Apply filter
                  if (_selectedFilter != 0 &&
                      review["rating"] != _selectedFilter) {
                    return SizedBox.shrink();
                  }

                  return Card(
                    color: Theme.of(context).cardTheme.color,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Customer Name & Rating
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                review["customerName"],
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                              ),
                              _buildStarRating(review["rating"]),
                            ],
                          ),

                          // Review Date
                          Text(review["date"],
                              style: Theme.of(context).textTheme.titleSmall!),

                          SizedBox(height: 8),

                          // Review Text
                          Text(review["review"],
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontWeight: FontWeight.bold)),

                          SizedBox(height: 8),

                          // Review Images
                          if (review["images"].isNotEmpty)
                            Wrap(
                              spacing: 8,
                              children: review["images"]
                                  .map<Widget>(
                                    (image) => ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(image,
                                          height: 80,
                                          width: 80,
                                          fit: BoxFit.cover),
                                    ),
                                  )
                                  .toList(),
                            ),

                          SizedBox(height: 8),

                          // Vendor Reply
                          if (review["reply"].isNotEmpty)
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Vendor's Reply:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text(review["reply"]),
                                ],
                              ),
                            )
                          else
                            TextButton(
                              onPressed: () {
                                _showReplyDialog(index);
                              },
                              child: Text("Reply",
                                  style: TextStyle(color: Colors.blue)),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Star Rating Widget
  Widget _buildStarRating(int rating) {
    return Row(
      children: List.generate(
        5,
        (index) => Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 20,
        ),
      ),
    );
  }

  // Rating Filter Buttons
  Widget _buildRatingFilter() {
    return Row(
      children: [
        for (int i = 0; i <= 5; i++)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedFilter = i;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  color: _selectedFilter == i ? Colors.blue : Colors.grey[200],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  i == 0 ? "All" : "$i★",
                  style: TextStyle(
                      color:
                          _selectedFilter == i ? Colors.white : Colors.black),
                ),
              ),
            ),
          ),
      ],
    );
  }

  // Reply Dialog
  void _showReplyDialog(int index) {
    TextEditingController _replyController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Reply to Review"),
        content: TextField(
          controller: _replyController,
          decoration: InputDecoration(hintText: "Enter your reply here"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              _replyToReview(index, _replyController.text);
              Navigator.pop(context);
            },
            child: Text("Reply"),
          ),
        ],
      ),
    );
  }
}
