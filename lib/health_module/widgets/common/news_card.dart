import 'package:flutter/material.dart';
import 'package:quamin_health_module/health_module/models/news_model.dart';
import 'package:quamin_health_module/health_module/screens/dashboard/tabs/news_detail_screen.dart';

class NewsCard extends StatelessWidget {
  final NewsArticle article;
  final double width;
  final double height;

  const NewsCard({
    Key? key,
    required this.article,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetailScreen(article: article),
          ),
        );
      },
      child: Container(
        width: width,
        margin: EdgeInsets.only(right: width / 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(height),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: _buildContent(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(double height) {
    return Hero(
      tag: 'news_image_${article.url}',
      child: Container(
        height: height * 0.4, // Adjust image height ratio
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          child: article.urlToImage != null
              ? Image.network(
                  article.urlToImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade200,
                      child: Center(
                        child: Icon(Icons.error_outline),
                      ),
                    );
                  },
                )
              : Container(
                  color: Colors.grey.shade200,
                  child: Center(
                    child: Icon(Icons.newspaper),
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          article.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 8),
        Expanded(
          child: Text(
            article.description,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                article.source.name,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsDetailScreen(article: article),
                  ),
                );
              },
              child: Text('Read More'),
            ),
          ],
        ),
      ],
    );
  }
}