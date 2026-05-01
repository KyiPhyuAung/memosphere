import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:share_plus/share_plus.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(const MemoSphereApp());
}

class MemoSphereApp extends StatefulWidget {
  const MemoSphereApp({super.key});

  @override
  State<MemoSphereApp> createState() => _MemoSphereAppState();
}



class WelcomeScreen extends StatelessWidget {
  final VoidCallback onStart;

  const WelcomeScreen({super.key, required this.onStart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF2563EB),
              Color(0xFF14B8A6),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('📝✨', style: TextStyle(fontSize: 90)),
              const SizedBox(height: 20),
              Text(
                'MemoSphere',
                style: GoogleFonts.spaceGrotesk(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.6,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Capture ideas. Attach memories.\nShare beautifully.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onStart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      '🚀 Get Started',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MemoSphereAppState extends State<MemoSphereApp> {
  bool isDark = false;

  @override
  void initState() {
    super.initState();
    loadSavedTheme();
  }

  Future<void> loadSavedTheme() async {
    final savedTheme = await DatabaseHelper.instance.readDarkMode();

    if (!mounted) return;

    setState(() {
      isDark = savedTheme;
    });
  }

  Future<void> toggleTheme() async {
    final nextValue = !isDark;

    setState(() {
      isDark = nextValue;
    });

    await DatabaseHelper.instance.saveDarkMode(nextValue);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MemoSphere',
      debugShowCheckedModeBanner: false,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: Builder(
      builder: (context) => WelcomeScreen(
        onStart: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => HomeScreen(
                isDark: isDark,
                onThemeChanged: toggleTheme,
              ),
            ),
          );
        },
      ),
    ),
    );
  }
}

class AppTheme {
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF8FAFC),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF2563EB),
      brightness: Brightness.light,
      primary: const Color(0xFF2563EB),
      secondary: const Color(0xFF14B8A6),
      surface: Colors.white,
      error: const Color(0xFFEF4444),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFF8FAFC),
      foregroundColor: Color(0xFF0F172A),
      elevation: 0,
      centerTitle: false,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF2563EB),
      foregroundColor: Colors.white,
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 8,
      shadowColor: const Color(0xFF2563EB).withOpacity(0.08),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(26),
      ),
    ),
    textTheme: GoogleFonts.nunitoSansTextTheme(),
    primaryTextTheme: GoogleFonts.nunitoSansTextTheme(),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
        borderSide: const BorderSide(color: Color(0xFF2563EB), width: 1.5),
      ),
      hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
    ),
  );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF020617),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF3B82F6),
      brightness: Brightness.dark,
      primary: const Color(0xFF3B82F6),
      secondary: const Color(0xFF2DD4BF),
      surface: const Color(0xFF0F172A),
      error: const Color(0xFFF87171),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF020617),
      foregroundColor: Color(0xFFF1F5F9),
      elevation: 0,
      centerTitle: false,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF3B82F6),
      foregroundColor: Colors.white,
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF0F172A),
      elevation: 10,
      shadowColor: const Color(0xFF3B82F6).withOpacity(0.12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(26),
      ),
    ),
    textTheme: GoogleFonts.nunitoSansTextTheme(ThemeData.dark().textTheme),
    primaryTextTheme: GoogleFonts.nunitoSansTextTheme(ThemeData.dark().primaryTextTheme),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF0F172A),
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
        borderSide: const BorderSide(color: Color(0xFF1E293B)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
        borderSide: const BorderSide(color: Color(0xFF1E293B)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
        borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 1.5),
      ),
      hintStyle: const TextStyle(color: Color(0xFF64748B)),
    ),
  );
}

class Post {
  final int? id;
  final String title;
  final String content;
  final String? imagePath;
  final String createdAt;

  Post({
    this.id,
    required this.title,
    required this.content,
    this.imagePath,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'imagePath': imagePath,
      'createdAt': createdAt,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'],
      title: map['title'] ?? 'Untitled Memo',
      content: map['content'],
      imagePath: map['imagePath'],
      createdAt: map['createdAt'],
    );
  }
}

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, 'memosphere.db');

    _database = await openDatabase(
      path,
      version: 3,
      onCreate: _createDatabase,
      onUpgrade: _upgradeDatabase,
    );

    return _database!;
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE posts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        imagePath TEXT,
        createdAt TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE settings (
        key TEXT PRIMARY KEY,
        value TEXT NOT NULL
      )
    ''');
  }

  Future<void> _upgradeDatabase(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute(
        "ALTER TABLE posts ADD COLUMN title TEXT NOT NULL DEFAULT 'Untitled Memo'",
      );
    }

    if (oldVersion < 3) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS settings (
          key TEXT PRIMARY KEY,
          value TEXT NOT NULL
        )
      ''');
    }
  }

  Future<bool> readDarkMode() async {
    final db = await instance.database;

    final result = await db.query(
      'settings',
      columns: ['value'],
      where: 'key = ?',
      whereArgs: ['isDarkMode'],
      limit: 1,
    );

    if (result.isEmpty) return false;
    return result.first['value'] == 'true';
  }

  Future<void> saveDarkMode(bool value) async {
    final db = await instance.database;

    await db.insert(
      'settings',
      {
        'key': 'isDarkMode',
        'value': value.toString(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> createPost(Post post) async {
    final db = await instance.database;
    return db.insert('posts', post.toMap());
  }

  Future<List<Post>> readPosts({String query = ''}) async {
    final db = await instance.database;

    final result = await db.query(
      'posts',
      where: query.isEmpty ? null : 'title LIKE ? OR content LIKE ?',
      whereArgs: query.isEmpty ? null : ['%$query%', '%$query%'],
      orderBy: 'id DESC',
    );

    return result.map((map) => Post.fromMap(map)).toList();
  }

  Future<int> updatePost(Post post) async {
    final db = await instance.database;

    return db.update(
      'posts',
      post.toMap(),
      where: 'id = ?',
      whereArgs: [post.id],
    );
  }

  Future<int> deletePost(int id) async {
    final db = await instance.database;

    return db.delete(
      'posts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteMultiple(List<int> ids) async {
    final db = await instance.database;

    for (final id in ids) {
      await db.delete(
        'posts',
        where: 'id = ?',
        whereArgs: [id],
      );
    }
  }
}

class HomeScreen extends StatefulWidget {
  final bool isDark;
  final VoidCallback onThemeChanged;

  const HomeScreen({
    super.key,
    required this.isDark,
    required this.onThemeChanged,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Post> posts = [];
  List<int> selectedIds = [];
  final TextEditingController searchController = TextEditingController();

  bool get isSelectionMode => selectedIds.isNotEmpty;

  @override
  void initState() {
    super.initState();
    loadPosts();
  }

  Future<void> loadPosts({String query = ''}) async {
    final data = await DatabaseHelper.instance.readPosts(query: query);

    setState(() {
      posts = data;
    });
  }

  void toggleSelection(int id) {
    setState(() {
      if (selectedIds.contains(id)) {
        selectedIds.remove(id);
      } else {
        selectedIds.add(id);
      }
    });
  }

  Future<void> deleteSelectedPosts() async {
    final count = selectedIds.length;

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: Text(
            'Delete selected memos?',
            style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w800),
          ),
          content: Text(
            count == 1
                ? 'This memo will be permanently deleted. This action cannot be undone.'
                : '$count memos will be permanently deleted. This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
                foregroundColor: Colors.white,
              ),
              onPressed: () => Navigator.pop(context, true),
              icon: const Icon(Icons.delete_outline),
              label: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (shouldDelete != true) return;

    await DatabaseHelper.instance.deleteMultiple(selectedIds);

    setState(() {
      selectedIds.clear();
    });

    await loadPosts(query: searchController.text);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            count == 1 ? 'Memo deleted successfully.' : '$count memos deleted successfully.',
          ),
        ),
      );
    }
  }

  void clearSelection() {
    setState(() {
      selectedIds.clear();
    });
  }

  Future<void> openAddScreen() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AddEditPostScreen(),
      ),
    );

    loadPosts(query: searchController.text);
  }

  Future<void> openDetailScreen(Post post) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailScreen(post: post),
      ),
    );

    loadPosts(query: searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: openAddScreen,
        icon: const Icon(Icons.add),
        label: const Text('✨ New Memo'),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 700;

            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isWide ? 850 : double.infinity,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _HeaderSection(
                        isDark: widget.isDark,
                        onThemeChanged: widget.onThemeChanged,
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: searchController,
                        onChanged: (value) => loadPosts(query: value),
                        decoration: const InputDecoration(
                          hintText: '🔍 Search your memos...',
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 220),
                        child: isSelectionMode
                            ? Padding(
                                key: const ValueKey('selection-toolbar'),
                                padding: const EdgeInsets.only(top: 12),
                                child: _SelectionToolbar(
                                  selectedCount: selectedIds.length,
                                  onDeleteSelected: deleteSelectedPosts,
                                  onClearSelection: clearSelection,
                                ),
                              )
                            : const SizedBox.shrink(
                                key: ValueKey('no-selection-toolbar'),
                              ),
                      ),
                      const SizedBox(height: 18),
                      Expanded(
                        child: posts.isEmpty
                            ? const EmptyState()
                            : ListView.builder(
                                itemCount: posts.length,
                                itemBuilder: (context, index) {
                                  final post = posts[index];
                                  final selected =
                                      selectedIds.contains(post.id);

                                  return PostCard(
                                    post: post,
                                    selected: selected,
                                    onTap: () {
                                      if (isSelectionMode) {
                                        toggleSelection(post.id!);
                                      } else {
                                        openDetailScreen(post);
                                      }
                                    },
                                    onLongPress: () {
                                      toggleSelection(post.id!);
                                    },
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  final bool isDark;
  final VoidCallback onThemeChanged;

  const _HeaderSection({
    required this.isDark,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  const Color(0xFF1E3A8A),
                  const Color(0xFF0F766E),
                ]
              : [
                  const Color(0xFF2563EB),
                  const Color(0xFF14B8A6),
                ],
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.22),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          const Text(
            '📝',
            style: TextStyle(fontSize: 38),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'MemoSphere',
                    style: GoogleFonts.spaceGrotesk(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '✨ Capture ideas, attach memories, and share beautifully.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.nunitoSans(
                    color: Colors.white.withOpacity(0.94),
                    fontSize: 13,
                    height: 1.25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: isDark ? 'Switch to light mode' : 'Switch to dark mode',
            onPressed: onThemeChanged,
            icon: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectionToolbar extends StatelessWidget {
  final int selectedCount;
  final VoidCallback onDeleteSelected;
  final VoidCallback onClearSelection;

  const _SelectionToolbar({
    required this.selectedCount,
    required this.onDeleteSelected,
    required this.onClearSelection,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF111827) : Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.18),
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.20)
                : const Color(0xFF2563EB).withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.12),
            ),
            child: Icon(
              Icons.check_circle_outline,
              color: Theme.of(context).colorScheme.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              '$selectedCount selected',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          TextButton(
            onPressed: onClearSelection,
            child: const Text('Cancel'),
          ),
          const SizedBox(width: 6),
          FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: onDeleteSelected,
            icon: const Icon(Icons.delete_outline, size: 19),
            label: Text(
              'Delete',
              style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.18),
              Theme.of(context).colorScheme.secondary.withOpacity(0.14),
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '📝✨',
              style: TextStyle(fontSize: 58),
            ),
            const SizedBox(height: 16),
            const Text(
              'No memos yet',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Start by creating your first beautiful memo.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).hintColor,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  final Post post;
  final bool selected;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const PostCard({
    super.key,
    required this.post,
    required this.selected,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final imageExists =
        post.imagePath != null && File(post.imagePath!).existsSync();

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: selected
            ? LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary.withOpacity(0.35),
                  Theme.of(context).colorScheme.secondary.withOpacity(0.25),
                ],
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.25)
                : const Color(0xFF2563EB).withOpacity(0.08),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(28),
          onTap: onTap,
          onLongPress: onLongPress,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                if (imageExists)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: Image.file(
                      File(post.imagePath!),
                      width: 92,
                      height: 92,
                      fit: BoxFit.cover,
                    ),
                  )
                else
                  Container(
                    width: 92,
                    height: 92,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.secondary,
                        ],
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        '📝',
                        style: TextStyle(fontSize: 36),
                      ),
                    ),
                  ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          height: 1.25,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        post.content,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.access_time, size: 14),
                          const SizedBox(width: 5),
                          Text(
                            post.createdAt,
                            style: TextStyle(
                              color: Theme.of(context).hintColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (selected)
                  Icon(
                    Icons.check_circle,
                    color: Theme.of(context).colorScheme.primary,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddEditPostScreen extends StatefulWidget {
  final Post? post;

  const AddEditPostScreen({
    super.key,
    this.post,
  });

  @override
  State<AddEditPostScreen> createState() => _AddEditPostScreenState();
}

class _AddEditPostScreenState extends State<AddEditPostScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  String? imagePath;

  bool get isEditing => widget.post != null;

  @override
  void initState() {
    super.initState();

    if (isEditing) {
      titleController.text = widget.post!.title;
      contentController.text = widget.post!.content;
      imagePath = widget.post!.imagePath;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedImage = await picker.pickImage(
      source: source,
      imageQuality: 80,
    );

    if (pickedImage != null) {
      setState(() {
        imagePath = pickedImage.path;
      });
    }
  }

  Future<void> savePost() async {
    final title = titleController.text.trim();
    final content = contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add a title and message first.')),
      );
      return;
    }

    if (isEditing) {
      final updatedPost = Post(
        id: widget.post!.id,
        title: title,
        content: content,
        imagePath: imagePath,
        createdAt: widget.post!.createdAt,
      );

      await DatabaseHelper.instance.updatePost(updatedPost);
    } else {
      final newPost = Post(
        title: title,
        content: content,
        imagePath: imagePath,
        createdAt: DateTime.now().toString().substring(0, 16),
      );

      await DatabaseHelper.instance.createPost(newPost);
    }

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageExists = imagePath != null && File(imagePath!).existsSync();

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? '✏️ Edit Memo' : '✨ Create Memo'),
        actions: [
          TextButton.icon(
            onPressed: savePost,
            icon: const Icon(Icons.check),
            label: const Text('Save'),
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 700;

            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isWide ? 850 : double.infinity,
                ),
                child: ListView(
                  padding: const EdgeInsets.all(18),
                  children: [
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.18),
                            Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.14),
                          ],
                        ),
                      ),
                      child: const Text(
                        '💭 Write something meaningful and attach a memory.',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    TextField(
                      controller: titleController,
                      maxLines: 1,
                      textInputAction: TextInputAction.next,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Add a title...',
                        prefixIcon: Icon(Icons.title),
                      ),
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      controller: contentController,
                      maxLines: 8,
                      style: GoogleFonts.nunitoSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 1.45,
                      ),
                      decoration: const InputDecoration(
                        hintText:
                            'Write your blog, wiki note, or social message...',
                      ),
                    ),
                    const SizedBox(height: 18),
                    if (imageExists)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Image.file(
                          File(imagePath!),
                          height: 240,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )
                    else
                      Container(
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Theme.of(context).dividerColor,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            '📸 No image attached',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton.icon(
                            onPressed: () => pickImage(ImageSource.gallery),
                            icon: const Icon(Icons.photo_library_outlined),
                            label: const Text('Gallery'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => pickImage(ImageSource.camera),
                            icon: const Icon(Icons.camera_alt_outlined),
                            label: const Text('Camera'),
                          ),
                        ),
                      ],
                    ),
                    if (imagePath != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: TextButton.icon(
                          onPressed: () {
                            setState(() {
                              imagePath = null;
                            });
                          },
                          icon: const Icon(Icons.close),
                          label: const Text('Remove Image'),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final Post post;

  const DetailScreen({
    super.key,
    required this.post,
  });

  Future<void> deletePost(BuildContext context) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: Text(
            'Delete this memo?',
            style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w800),
          ),
          content: const Text(
            'This memo will be permanently deleted. This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
                foregroundColor: Colors.white,
              ),
              onPressed: () => Navigator.pop(context, true),
              icon: const Icon(Icons.delete_outline),
              label: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (shouldDelete != true) return;

    await DatabaseHelper.instance.deletePost(post.id!);

    if (context.mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Memo deleted successfully.')),
      );
    }
  }

  Future<void> sharePost() async {
    if (post.imagePath != null && File(post.imagePath!).existsSync()) {
      await Share.shareXFiles(
        [XFile(post.imagePath!)],
        text: '${post.title}\n\n${post.content}',
      );
    } else {
      await Share.share('${post.title}\n\n${post.content}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageExists =
        post.imagePath != null && File(post.imagePath!).existsSync();

    return Scaffold(
      appBar: AppBar(
        title: const Text('📖 Memo Detail'),
        actions: [
          IconButton(
            onPressed: sharePost,
            icon: const Icon(Icons.share_outlined),
          ),
          IconButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddEditPostScreen(post: post),
                ),
              );

              if (context.mounted) {
                Navigator.pop(context);
              }
            },
            icon: const Icon(Icons.edit_outlined),
          ),
          IconButton(
            tooltip: 'Delete memo',
            onPressed: () => deletePost(context),
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 700;

            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isWide ? 850 : double.infinity,
                ),
                child: ListView(
                  padding: const EdgeInsets.all(18),
                  children: [
                    if (imageExists)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(28),
                        child: Image.file(
                          File(post.imagePath!),
                          height: 280,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    if (imageExists) const SizedBox(height: 18),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(22),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post.title,
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 24,
                                height: 1.25,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              post.content,
                              style: GoogleFonts.nunitoSans(
                                fontSize: 18,
                                height: 1.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 18),
                            Text(
                              'Created at: ${post.createdAt}',
                              style: TextStyle(
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            const SizedBox(height: 18),
                            SizedBox(
                              width: double.infinity,
                              child: FilledButton.icon(
                                onPressed: sharePost,
                                icon: const Icon(Icons.share),
                                label: const Text('Share Memo'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}