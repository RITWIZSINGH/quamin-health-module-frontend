import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quamin_health_module/health_module/models/news_model.dart';

class NewsDetailScreen extends StatelessWidget {
  final NewsArticle article;

  const NewsDetailScreen({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  article.source.name,
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
              background: Hero(
                tag: 'news_image_${article.url}',
                child: article.urlToImage != null
                    ? Image.network(
                        article.urlToImage!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey.shade200,
                            child: Center(
                              child: Icon(Icons.error_outline, size: 48),
                            ),
                          );
                        },
                      )
                    : Container(
                        color: Colors.grey.shade200,
                        child: Center(
                          child: Icon(Icons.newspaper, size: 48),
                        ),
                      ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                      SizedBox(width: 8),
                      Text(
                        DateFormat('MMM dd, yyyy HH:mm')
                            .format(DateTime.parse(article.publishedAt)),
                        style: TextStyle(color: Colors.grey),
                      ),
                      if (article.author != null) ...[
                        SizedBox(width: 16),
                        Icon(Icons.person_outline, size: 16, color: Colors.grey),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            article.author!,
                            style: TextStyle(color: Colors.grey),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 24),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      article.description,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontStyle: FontStyle.italic,
                          ),
                    ),
                  ),
                  SizedBox(height: 24),
                  SelectableText(
                    article.content,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          height: 1.8,
                          fontSize: 16,
                        ),
                  ),
                  SizedBox(height: 32),
                  if (article.url.isNotEmpty)
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Implement URL launcher
                        },
                        icon: Icon(Icons.launch),
                        label: Text('Read Original Article'),
                      ),
                    ),
                  SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}