import 'package:flutter/material.dart';

class TestimonialCard extends StatelessWidget {
  final String testimonialText;
  final String authorName;
  final String authorDetails;
  final ImageProvider authorImage;
  final int rating;
  final VoidCallback onTap;

  const TestimonialCard({
    Key? key,
    required this.testimonialText,
    required this.authorName,
    required this.authorDetails,
    required this.authorImage,
    required this.rating,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 300,
        child: Card(
          elevation: 4.0,
          margin: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  '"$testimonialText"',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 4.0),
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: authorImage,
                    ),
                    SizedBox(width: 8.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          authorName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(authorDetails),
                        ),
                        Row(
                          children: List.generate(
                              5,
                              (index) => Icon(
                                    index < rating
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: index < rating
                                        ? Colors.amber
                                        : Colors.grey,
                                  )),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


/*import 'package:flutter/material.dart';

class TestimonialCard extends StatelessWidget {
  final String testimonialText;
  final String authorName;
  final String authorDetails;
  final ImageProvider authorImage;
  final VoidCallback onTap;

  const TestimonialCard({
    Key? key,
    required this.testimonialText,
    required this.authorName,
    required this.authorDetails,
    required this.authorImage,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 300, // Ancho fijo para el card
        child: Card(
          elevation: 4.0,
          margin: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  '"$testimonialText"',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: authorImage,
                    ),
                    SizedBox(width: 8.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          authorName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(authorDetails),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


*/
/*import 'package:flutter/material.dart';

class TestimonialCard extends StatelessWidget {
  final String testimonialText;
  final String authorName;
  final String authorDetails;
  final ImageProvider authorImage;

  const TestimonialCard({
    Key? key,
    required this.testimonialText,
    required this.authorName,
    required this.authorDetails,
    required this.authorImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              '"$testimonialText"',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: authorImage,
                ),
                SizedBox(width: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      authorName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(authorDetails),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
*/