import 'package:flutter/material.dart';

void main() {
  runApp(const SmallBusinessAIHubApp());
}

class SmallBusinessAIHubApp extends StatelessWidget {
  const SmallBusinessAIHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Small Business AI Hub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const DashboardScreen(),
        '/caption_generator': (context) => const CaptionGeneratorScreen(),
      },
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tools = [
      {
        'title': 'Customer Reply Assistant',
        'icon': Icons.chat_bubble_outline,
        'description': 'Generate professional replies for WhatsApp & IG.',
        'route': null,
      },
      {
        'title': 'Invoice Extractor',
        'icon': Icons.receipt_long,
        'description': 'Extract names, amounts, and dates automatically.',
        'route': null,
      },
      {
        'title': 'Caption Generator',
        'icon': Icons.image_outlined,
        'description': 'Create Instagram captions & hashtags in seconds.',
        'route': '/caption_generator',
      },
      {
        'title': 'Customer FAQ Bot',
        'icon': Icons.smart_toy_outlined,
        'description': 'Answer common customer questions 24/7.',
        'route': null,
      },
      {
        'title': 'Lead Follow-up',
        'icon': Icons.trending_up,
        'description': 'Identify and track leads from Google Sheets.',
        'route': null,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Small Business AI Hub', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 1,
        shadowColor: Colors.black12,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = constraints.maxWidth > 800 ? 3 : constraints.maxWidth > 500 ? 2 : 1;
            return GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: 1.5,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: tools.length,
              itemBuilder: (context, index) {
                final tool = tools[index];
                final isAvailable = tool['route'] != null;
                return Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: Colors.grey.shade200),
                  ),
                  color: Colors.white,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: isAvailable
                        ? () => Navigator.pushNamed(context, tool['route'] as String)
                        : () => ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${tool['title']} coming soon!')),
                            ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              tool['icon'] as IconData,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            tool['title'] as String,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            tool['description'] as String,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class CaptionGeneratorScreen extends StatefulWidget {
  const CaptionGeneratorScreen({super.key});

  @override
  State<CaptionGeneratorScreen> createState() => _CaptionGeneratorScreenState();
}

class _CaptionGeneratorScreenState extends State<CaptionGeneratorScreen> {
  final _productController = TextEditingController();
  final _featuresController = TextEditingController();
  bool _isGenerating = false;
  String? _generatedCaption;

  void _generateCaption() {
    if (_productController.text.isEmpty || _featuresController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in both fields')),
      );
      return;
    }

    setState(() {
      _isGenerating = true;
      _generatedCaption = null;
    });

    // Simulate AI generation delay
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() {
        _isGenerating = false;
        _generatedCaption = '''🌟 Introducing ${_productController.text}! 🌟\n\nLooking for the perfect solution? We've got you covered. This amazing product features:\n✨ ${_featuresController.text}\n\nGet yours today and transform your routine! Link in bio to shop now. 🛍️\n\n#${_productController.text.replaceAll(' ', '')} #SmallBusiness #MustHave #ShopLocal''';
      });
    });
  }

  @override
  void dispose() {
    _productController.dispose();
    _featuresController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Caption Generator'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 1,
        shadowColor: Colors.black12,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Create an engaging post',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Enter your product details and let AI do the writing.',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _productController,
                decoration: InputDecoration(
                  labelText: 'Product Name',
                  hintText: 'e.g. Lavender Scented Candle',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _featuresController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Key Features / Benefits',
                  hintText: 'e.g. 100% soy wax, 40-hour burn time, relaxing scent',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _isGenerating ? null : _generateCaption,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isGenerating
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'Generate Caption',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
              ),
              if (_generatedCaption != null) ...[
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Generated Result',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.copy, size: 20),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Copied to clipboard!')),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _generatedCaption!,
                        style: const TextStyle(fontSize: 15, height: 1.5),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}