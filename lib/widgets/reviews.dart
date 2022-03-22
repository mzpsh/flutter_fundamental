import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_fundamental/models/restaurant.dart';
import 'package:flutter_fundamental/utils/restaurant_getter.dart';
import 'package:http/http.dart' as http;

class Reviews extends StatefulWidget {
  final String restaurantId;
  const Reviews({required this.restaurantId, Key? key}) : super(key: key);

  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  bool _isReviewsOpen = false;
  final _formKey = GlobalKey<FormState>();
  final _nameTextController = TextEditingController();
  final _reviewTextController = TextEditingController();

  void _postReview() async {
    void showFailedSnackbar() {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 1),
          content: Text('Failed to add a review.'),
        ),
      );
    }

    final name = _nameTextController.text;
    final review = _reviewTextController.text;
    final url = Uri.parse('https://restaurant-api.dicoding.dev/review');
    try {
      final response = await http.post(url, body: {
        "id": widget.restaurantId,
        "name": name,
        "review": review,
      });
      final body = jsonDecode(response.body);

      if (body['error']) {
        showFailedSnackbar();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 1),
            content: Text('Review added.'),
          ),
        );
      }
    } catch (e) {
      showFailedSnackbar();
      rethrow;
    }
    setState(() {});
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _reviewTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _isReviewsOpen = !_isReviewsOpen;
            });
          },
          child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 18, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "REVIEWS",
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF062006),
                        ),
                  ),
                  Icon(_isReviewsOpen ? Icons.expand_less : Icons.expand_more)
                ],
              )),
        ),
        (_isReviewsOpen
            ? FutureBuilder(
                future: RestaurantGetter.getRestaurantDetailFromAPI(
                    widget.restaurantId),
                builder: (context, snapshot) {
                  Widget renderAddReviewDialog() {
                    return Form(
                      key: _formKey,
                      child: AlertDialog(
                        title: const Text('Add Review'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: _nameTextController,
                              decoration:
                                  const InputDecoration(hintText: 'Name'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            TextFormField(
                              controller: _reviewTextController,
                              minLines: 5,
                              maxLines: 10,
                              decoration: const InputDecoration(
                                  hintText:
                                      'Your thoughts about this restaurant.'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('CANCEL'),
                          ),
                          TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _postReview();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    duration: Duration(seconds: 1),
                                    content: Text('Adding a review...'),
                                  ),
                                );
                                Navigator.pop(context);
                              }
                            },
                            child: const Text('POST'),
                          ),
                        ],
                      ),
                    );
                  }

                  Widget renderAddReviewButton() {
                    return Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: OutlinedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => renderAddReviewDialog());
                        },
                        child: const Text('ADD REVIEW'),
                      ),
                    );
                  }

                  Widget renderReview(element) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              element['name'],
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Text(element['review']),
                          ],
                        ));
                  }

                  Widget renderError() {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Text(
                          'Error has occured. Check your connection.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return renderError();
                  } else if (snapshot.hasData) {
                    final restaurant = snapshot.data as Restaurant;
                    final reviews = restaurant.customerReviews;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...reviews
                            .map((element) => renderReview(element))
                            .toList(),
                        renderAddReviewButton()
                      ],
                    );
                  } else {
                    return const Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              )
            : const SizedBox.shrink())
      ],
    );
  }
}
