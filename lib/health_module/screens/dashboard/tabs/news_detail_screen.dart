import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quamin_health_module/health_module/models/news_model.dart';

class NewsDetailScreen extends StatelessWidget {
  final NewsArticle article;

  const NewsDetailScreen({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            floating: false,
            pinned: true,
            elevation: 0,
            backgroundColor:
                Theme.of(context).primaryColor.withValues(alpha: 0.8),
            leading: IconButton(
              icon: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.arrow_back, color: Colors.black87),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: EdgeInsets.only(left: 16, bottom: 16, right: 16),
              title: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black54, Colors.black38],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  article.source.name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              background: Hero(
                tag: 'news_image_${article.url}',
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    article.urlToImage != null
                        ? Image.network(
                            article.urlToImage!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return _buildErrorImage();
                            },
                          )
                        : _buildErrorImage(),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.7),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          height: 1.4,
                        ),
                  ),
                  SizedBox(height: 20),
                  _buildMetadataRow(),
                  SizedBox(height: 24),
                  _buildDescriptionCard(context),
                  SizedBox(height: 24),
                  _buildContent(context),
                  SizedBox(height: 32),
                  _buildReadMoreButton(),
                  SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorImage() {
    return Container(
      color: Colors.grey.shade200,
      child: Center(
        child: Icon(
          Icons.newspaper,
          size: 64,
          color: Colors.grey.shade400,
        ),
      ),
    );
  }

  Widget _buildMetadataRow() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.calendar_today, size: 16, color: Colors.grey.shade700),
          SizedBox(width: 8),
          Text(
            DateFormat('MMM dd, yyyy HH:mm')
                .format(DateTime.parse(article.publishedAt)),
            style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
          ),
          if (article.author != null) ...[
            SizedBox(width: 16),
            Icon(Icons.person_outline, size: 16, color: Colors.grey.shade700),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                article.author!,
                style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDescriptionCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor.withValues(alpha: 0.1),
            Theme.of(context).primaryColor.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        article.description,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontStyle: FontStyle.italic,
              height: 1.6,
              color: Colors.black87,
            ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SelectableText(
      article.content,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            height: 1.8,
            fontSize: 16,
            color: Colors.black87,
          ),
    );
  }

  Widget _buildReadMoreButton() {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () {
          // Implement URL launcher
        },
        icon: Icon(Icons.launch),
        label: Text('Read Full Article'),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
