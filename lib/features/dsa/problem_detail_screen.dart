import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../data/models/problem.dart';
import '../../data/models/problem_content.dart';
import 'tabs/problem_tab.dart';
import 'tabs/editorial_tab.dart';
import 'tabs/submissions_tab.dart';

// Default content used as fallback for problems without their own data
const _defaultDescription =
    'Given a sorted array nums and an integer x. Find the floor and ceil of x in nums. '
    'The floor of x is the largest element in the array which is smaller than or equal to x. '
    'The ceiling of x is the smallest element in the array greater than or equal to x. '
    'If no floor or ceil exists, output -1.';

const _defaultExamples = [
  ProblemExample(
    input: 'Input : nums =[3, 4, 4, 7, 8, 10], x= 5',
    output: 'Output: 4 7',
    explanation:
        'Explanation: The floor of 5 in the array is 4, and the ceiling of 5 in the array is 7.',
  ),
  ProblemExample(
    input: 'Input : nums =[3, 4, 4, 7, 8, 10], x= 8',
    output: 'Output: 8 8',
    explanation:
        'Explanation: The floor of 8 in the array is 8, and the ceiling of 8 is also 8.',
  ),
];

const _defaultPracticeOptions = [
  PracticeOption(label: '[2, 14]'),
  PracticeOption(label: '[-1, 2]', isCorrect: true),
  PracticeOption(label: '[-1, 14]'),
  PracticeOption(label: '[2, -1]'),
];

const _defaultEditorial = EditorialContent(
  videoUrl:
      'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
  approaches: [
    Approach(
      name: 'Brute Force',
      intuition:
          'Linearly iterate through the array. For floor, find the largest element <= x. For ceil, find the smallest element >= x.',
      code: '''int findFloor(vector<int>& nums, int x) {
    int floor = -1;
    for (int i = 0; i < nums.size(); i++) {
        if (nums[i] <= x) floor = nums[i];
    }
    return floor;
}

int findCeil(vector<int>& nums, int x) {
    int ceil = -1;
    for (int i = 0; i < nums.size(); i++) {
        if (nums[i] >= x) { ceil = nums[i]; break; }
    }
    return ceil;
}''',
      timeComplexity: 'O(n)',
      spaceComplexity: 'O(1)',
    ),
    Approach(
      name: 'Optimal (Binary Search)',
      intuition:
          'Use binary search to find floor and ceil. For floor: if mid <= x, update floor and move right. For ceil: if mid >= x, update ceil and move left.',
      code: '''pair<int,int> floorCeil(vector<int>& nums, int x) {
    int lo = 0, hi = nums.size() - 1;
    int floor = -1, ceil = -1;

    while (lo <= hi) {
        int mid = lo + (hi - lo) / 2;
        if (nums[mid] <= x) { floor = nums[mid]; lo = mid + 1; }
        else { hi = mid - 1; }
    }

    lo = 0; hi = nums.size() - 1;
    while (lo <= hi) {
        int mid = lo + (hi - lo) / 2;
        if (nums[mid] >= x) { ceil = nums[mid]; hi = mid - 1; }
        else { lo = mid + 1; }
    }
    return {floor, ceil};
}''',
      timeComplexity: 'O(log n)',
      spaceComplexity: 'O(1)',
    ),
  ],
);

class ProblemDetailScreen extends StatefulWidget {
  final Problem problem;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;
  final bool hasPrevious;
  final bool hasNext;

  const ProblemDetailScreen({
    super.key,
    required this.problem,
    this.onPrevious,
    this.onNext,
    this.hasPrevious = false,
    this.hasNext = false,
  });

  @override
  State<ProblemDetailScreen> createState() => _ProblemDetailScreenState();
}

class _ProblemDetailScreenState extends State<ProblemDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// Returns the problem with default fallback content filled in
  Problem get _effectiveProblem {
    return widget.problem.copyWith(
      description: widget.problem.description ?? _defaultDescription,
      examples: widget.problem.examples.isEmpty
          ? _defaultExamples
          : widget.problem.examples,
      practiceOptions: widget.problem.practiceOptions.isEmpty
          ? _defaultPracticeOptions
          : widget.problem.practiceOptions,
      hints: widget.problem.hints.isEmpty
          ? ['Think about using binary search.']
          : widget.problem.hints,
      companyTags: widget.problem.companyTags.isEmpty
          ? ['Google', 'Amazon', 'Microsoft']
          : widget.problem.companyTags,
      editorial: widget.problem.editorial ?? _defaultEditorial,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final problem = _effectiveProblem;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Tab bar
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isDark
                        ? AppColors.darkBorder
                        : AppColors.lightBorder,
                    width: 0.5,
                  ),
                ),
              ),
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                labelColor: AppColors.amber,
                unselectedLabelColor: isDark
                    ? AppColors.textGray
                    : AppColors.textMuted,
                indicatorColor: AppColors.amber,
                indicatorWeight: 2.5,
                labelStyle: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.description_outlined, size: 16),
                        const SizedBox(width: 6),
                        const Text('Problem'),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.menu_book_rounded, size: 16),
                        const SizedBox(width: 6),
                        const Text('Editorial'),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.history_rounded, size: 16),
                        const SizedBox(width: 6),
                        const Text('Submissions'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Tab content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  ProblemTab(problem: problem),
                  EditorialTab(problem: problem),
                  const SubmissionsTab(),
                ],
              ),
            ),

            // Bottom bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                border: Border(
                  top: BorderSide(
                    color: isDark
                        ? AppColors.darkBorder
                        : AppColors.lightBorder,
                    width: 0.5,
                  ),
                ),
              ),
              child: Row(
                children: [
                  // Action icons
                  _BottomIcon(Icons.thumb_up_outlined, isDark),
                  const SizedBox(width: 4),
                  Text(
                    '11',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: isDark ? AppColors.textGray : AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(width: 12),
                  _BottomIcon(Icons.thumb_down_outlined, isDark),
                  const SizedBox(width: 16),
                  _BottomIcon(Icons.wb_sunny_outlined, isDark),
                  const SizedBox(width: 16),
                  _BottomIcon(Icons.lightbulb_outline_rounded, isDark),

                  const Spacer(),

                  // Checkmark button
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: AppColors.success,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Previous / Next navigation
                  GestureDetector(
                    onTap: widget.hasPrevious
                        ? () {
                            Navigator.pop(context);
                            widget.onPrevious?.call();
                          }
                        : null,
                    child: Icon(
                      Icons.chevron_left_rounded,
                      size: 26,
                      color: widget.hasPrevious
                          ? (isDark ? AppColors.textWhite : AppColors.textDark)
                          : (isDark
                                ? AppColors.darkBorder
                                : AppColors.lightBorder),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: widget.hasNext
                        ? () {
                            Navigator.pop(context);
                            widget.onNext?.call();
                          }
                        : null,
                    child: Icon(
                      Icons.chevron_right_rounded,
                      size: 26,
                      color: widget.hasNext
                          ? (isDark ? AppColors.textWhite : AppColors.textDark)
                          : (isDark
                                ? AppColors.darkBorder
                                : AppColors.lightBorder),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomIcon extends StatelessWidget {
  final IconData icon;
  final bool isDark;

  const _BottomIcon(this.icon, this.isDark);

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: 20,
      color: isDark ? AppColors.textGray : AppColors.textMuted,
    );
  }
}
