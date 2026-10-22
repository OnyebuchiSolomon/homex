import 'package:flutter/material.dart';
import 'package:homex/ui/global.dart';

class ReviewSellerScreen extends StatefulWidget {
  const ReviewSellerScreen({super.key});

  @override
  State<ReviewSellerScreen> createState() => _ReviewSellerScreenState();
}

class _ReviewSellerScreenState extends State<ReviewSellerScreen> {
  final TextEditingController _feedbackController = TextEditingController();

  final Map<String, int> _ratings = {
    'Property Accuracy': 0,
    'Communication': 0,
    'Respectfulness': 0,
    'Handover Process': 0,
  };

  bool _recommendSeller = false;

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  void _setRating(String category, int rating) {
    setState(() {
      _ratings[category] = rating;
    });
  }

  void _submitReview() {
    final hasAllRatings = _ratings.values.every((rating) => rating > 0);

    if (!hasAllRatings) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please rate all categories.')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Review submitted successfully.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Scaffold(
      backgroundColor: colors.surface,

      appBar: AppBar(
        backgroundColor: colors.surface,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_rounded),
          color: colors.primary,
        ),
        title: Text(
          'Rate Your Experience',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: textTheme.titleLarge?.copyWith(
            color: colors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ----------------------------------------------------------------
              // SELLER CARD
              // ----------------------------------------------------------------
              CustomCard(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: colors.surfaceContainer,
                        shape: BoxShape.circle,
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.network(
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuAseFESfC9RCywvP84fL3NuTTo_4j1nKBBM9KPvmqu6m9Aql6l9APemuRuOX8-OO1fz5EJwkE_t7dbJ8vgcdoY5r4wUD609PiEGffouIZ8dvURq4dhIQK2sDmSLGjIMVnLaJmuOCZEo1Sz6xTpVdDINwQzOGAJy5tNPkM2j3I602gA1TE6oBt2yLTnmXGyT3LHZoJzKJtqlqoRdptgQAyAz7Y45rFpOCG1KMcnm9acnJ3_kRK-l9Z6n',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.person_outline_rounded,
                            size: 32,
                            color: colors.onSurfaceVariant,
                          );
                        },
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'John Okafor',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.titleMedium?.copyWith(
                              color: colors.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            'Property Owner',
                            style: textTheme.bodyMedium?.copyWith(
                              color: colors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 8),

                    Icon(
                      Icons.verified_rounded,
                      color: colors.secondaryContainer,
                      size: 24,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // ----------------------------------------------------------------
              // DETAILED RATINGS
              // ----------------------------------------------------------------
              Text(
                'Detailed Ratings',
                style: textTheme.titleMedium?.copyWith(
                  color: colors.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 8),

              Divider(color: colors.surfaceContainerHighest, height: 1),

              const SizedBox(height: 16),

              _RatingRow(
                title: 'Property Accuracy',
                rating: _ratings['Property Accuracy'] ?? 0,
                onRatingChanged: (rating) {
                  _setRating('Property Accuracy', rating);
                },
              ),

              const SizedBox(height: 20),

              _RatingRow(
                title: 'Communication',
                rating: _ratings['Communication'] ?? 0,
                onRatingChanged: (rating) {
                  _setRating('Communication', rating);
                },
              ),

              const SizedBox(height: 20),

              _RatingRow(
                title: 'Respectfulness',
                rating: _ratings['Respectfulness'] ?? 0,
                onRatingChanged: (rating) {
                  _setRating('Respectfulness', rating);
                },
              ),

              const SizedBox(height: 20),

              _RatingRow(
                title: 'Handover Process',
                rating: _ratings['Handover Process'] ?? 0,
                onRatingChanged: (rating) {
                  _setRating('Handover Process', rating);
                },
              ),

              const SizedBox(height: 28),

              // ----------------------------------------------------------------
              // WRITTEN FEEDBACK
              // ----------------------------------------------------------------
              Text(
                'Written Feedback',
                style: textTheme.labelLarge?.copyWith(
                  color: colors.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 8),

              TextField(
                controller: _feedbackController,
                maxLines: 4,
                textInputAction: TextInputAction.newline,
                style: textTheme.bodyLarge?.copyWith(color: colors.onSurface),
                decoration: InputDecoration(
                  hintText: 'Share your detailed feedback...',
                  hintStyle: textTheme.bodyLarge?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                  filled: true,
                  fillColor: colors.surfaceContainerLowest,
                  contentPadding: const EdgeInsets.all(16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: colors.surfaceContainerHighest,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: colors.surfaceContainerHighest,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colors.primary, width: 1.5),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ----------------------------------------------------------------
              // RECOMMEND SELLER
              // ----------------------------------------------------------------
              CustomCard(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),

                child: CheckboxListTile(
                  value: _recommendSeller,
                  onChanged: (value) {
                    setState(() {
                      _recommendSeller = value ?? false;
                    });
                  },
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: colors.primary,
                  checkColor: colors.onPrimary,
                  title: Text(
                    'I would recommend this seller',
                    style: textTheme.bodyLarge?.copyWith(
                      color: colors.onSurface,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ----------------------------------------------------------------
              // SUBMIT BUTTON
              // ----------------------------------------------------------------
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitReview,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                    foregroundColor: colors.onPrimary,
                    elevation: 2,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Submit Review',
                    style: textTheme.labelLarge?.copyWith(
                      color: colors.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// RATING ROW
// ============================================================================

class _RatingRow extends StatelessWidget {
  final String title;
  final int rating;
  final ValueChanged<int> onRatingChanged;

  const _RatingRow({
    required this.title,
    required this.rating,
    required this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.labelLarge?.copyWith(
            color: colors.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 8),

        Row(
          children: List.generate(5, (index) {
            final starNumber = index + 1;
            final isSelected = starNumber <= rating;

            return GestureDetector(
              onTap: () => onRatingChanged(starNumber),
              child: Padding(
                padding: const EdgeInsets.only(right: 6),
                child: Icon(
                  isSelected ? Icons.star_rounded : Icons.star_outline_rounded,
                  size: 32,
                  color: isSelected
                      ? colors.secondaryContainer
                      : colors.outlineVariant,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
