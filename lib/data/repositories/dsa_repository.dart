import '../models/topic.dart';
import '../models/problem.dart';
import '../models/problem_content.dart';
import '../models/course.dart';

class DsaRepository {
  static Course getCourse() {
    return const Course(
      id: 'dsa',
      title: 'DSA',
      subtitle: 'Learn DSA Basics to Advanced',
      iconName: 'code',
      colorValue: 0xFFE2703A,
      progress: 0.35,
      totalTopics: 456,
      completedTopics: 160,
    );
  }

  static List<Topic> getSheetSteps() {
    return [
      Topic(
        id: 'step1',
        title: 'Step 1: Learn the Basics',
        description: 'Things to know in C++/Java/Python or any language',
        totalProblems: 31,
        completedProblems: 18,
        problems: _step1Problems(),
      ),
      Topic(
        id: 'step2',
        title: 'Step 2: Sorting Techniques',
        description: 'Learn all sorting algorithms',
        totalProblems: 7,
        completedProblems: 7,
        problems: _step2Problems(),
      ),
      Topic(
        id: 'step3',
        title: 'Step 3: Arrays',
        description: 'Hard / Medium / Easy problems on Arrays',
        totalProblems: 40,
        completedProblems: 12,
        problems: _step3Problems(),
      ),
      Topic(
        id: 'step4',
        title: 'Step 4: Binary Search',
        description: '1D, 2D Arrays and Search Space',
        totalProblems: 32,
        completedProblems: 8,
        problems: _step4Problems(),
      ),
      Topic(
        id: 'step5',
        title: 'Step 5: Strings',
        description: 'Basic and Medium string problems',
        totalProblems: 15,
        completedProblems: 3,
        problems: _step5Problems(),
      ),
      const Topic(
        id: 'step6',
        title: 'Step 6: Linked List',
        description: 'Single, Double LL, and Medium/Hard problems',
        totalProblems: 31,
        completedProblems: 0,
      ),
      const Topic(
        id: 'step7',
        title: 'Step 7: Recursion',
        description: 'Pattern-wise problems on recursion',
        totalProblems: 25,
        completedProblems: 5,
      ),
      const Topic(
        id: 'step8',
        title: 'Step 8: Bit Manipulation',
        description: 'From basics to advanced bit manipulation',
        totalProblems: 18,
        completedProblems: 0,
      ),
      const Topic(
        id: 'step9',
        title: 'Step 9: Stack and Queues',
        description: 'Learning, implementation and problems',
        totalProblems: 30,
        completedProblems: 10,
      ),
      const Topic(
        id: 'step10',
        title: 'Step 10: Sliding Window',
        description: 'Two pointer and sliding window',
        totalProblems: 12,
        completedProblems: 0,
      ),
      const Topic(
        id: 'step11',
        title: 'Step 11: Heaps',
        description: 'Learning, implementation, and problems',
        totalProblems: 17,
        completedProblems: 2,
      ),
      const Topic(
        id: 'step12',
        title: 'Step 12: Greedy Algorithms',
        description: 'Easy to hard greedy problems',
        totalProblems: 16,
        completedProblems: 0,
      ),
      const Topic(
        id: 'step13',
        title: 'Step 13: Binary Trees',
        description: 'Traversals, Medium and Hard problems',
        totalProblems: 39,
        completedProblems: 15,
      ),
      const Topic(
        id: 'step14',
        title: 'Step 14: Binary Search Trees',
        description: 'Concept and problems',
        totalProblems: 16,
        completedProblems: 4,
      ),
      const Topic(
        id: 'step15',
        title: 'Step 15: Graphs',
        description: 'BFS/DFS, Topo Sort, Shortest Path, MST',
        totalProblems: 54,
        completedProblems: 20,
      ),
      const Topic(
        id: 'step16',
        title: 'Step 16: Dynamic Programming',
        description: 'All patterns of DP',
        totalProblems: 56,
        completedProblems: 30,
      ),
      const Topic(
        id: 'step17',
        title: 'Step 17: Tries',
        description: 'Theory and problems on Tries',
        totalProblems: 7,
        completedProblems: 0,
      ),
    ];
  }

  static List<Problem> _step1Problems() {
    return const [
      Problem(
        id: 'p1',
        title: 'User Input / Output',
        difficulty: Difficulty.easy,
        isCompleted: true,
      ),
      Problem(
        id: 'p2',
        title: 'Data Types',
        difficulty: Difficulty.easy,
        isCompleted: true,
      ),
      Problem(
        id: 'p3',
        title: 'If Else Statements',
        difficulty: Difficulty.easy,
        isCompleted: true,
      ),
      Problem(
        id: 'p4',
        title: 'Switch Statement',
        difficulty: Difficulty.easy,
        isCompleted: true,
      ),
      Problem(
        id: 'p5',
        title: 'Arrays / Strings',
        difficulty: Difficulty.easy,
        isCompleted: true,
      ),
      Problem(
        id: 'p6',
        title: 'For Loops',
        difficulty: Difficulty.easy,
        isCompleted: true,
      ),
      Problem(
        id: 'p7',
        title: 'While Loops',
        difficulty: Difficulty.easy,
        isCompleted: true,
      ),
      Problem(
        id: 'p8',
        title: 'Functions',
        difficulty: Difficulty.easy,
        isCompleted: false,
      ),
      Problem(
        id: 'p9',
        title: 'Time Complexity',
        difficulty: Difficulty.medium,
        isCompleted: true,
      ),
      Problem(
        id: 'p10',
        title: 'Space Complexity',
        difficulty: Difficulty.medium,
        isCompleted: false,
      ),
      Problem(
        id: 'p11',
        title: 'Pattern - 1 (Rectangular Star)',
        difficulty: Difficulty.easy,
        isCompleted: true,
      ),
      Problem(
        id: 'p12',
        title: 'Pattern - 2 (Right Triangle)',
        difficulty: Difficulty.easy,
        isCompleted: true,
      ),
      Problem(
        id: 'p13',
        title: 'Pattern - 3 (Number Triangle)',
        difficulty: Difficulty.easy,
        isCompleted: true,
      ),
      Problem(
        id: 'p14',
        title: 'Count Digits',
        difficulty: Difficulty.easy,
        isCompleted: true,
      ),
      Problem(
        id: 'p15',
        title: 'Reverse a Number',
        difficulty: Difficulty.easy,
        isCompleted: true,
      ),
      Problem(
        id: 'p16',
        title: 'Check Palindrome',
        difficulty: Difficulty.easy,
        isCompleted: true,
      ),
      Problem(
        id: 'p17',
        title: 'GCD or HCF',
        difficulty: Difficulty.easy,
        isCompleted: true,
      ),
      Problem(
        id: 'p18',
        title: 'Armstrong Numbers',
        difficulty: Difficulty.easy,
        isCompleted: true,
      ),
    ];
  }

  static List<Problem> _step2Problems() {
    return const [
      Problem(
        id: 'p19',
        title: 'Selection Sort',
        difficulty: Difficulty.easy,
        isCompleted: true,
      ),
      Problem(
        id: 'p20',
        title: 'Bubble Sort',
        difficulty: Difficulty.easy,
        isCompleted: true,
      ),
      Problem(
        id: 'p21',
        title: 'Insertion Sort',
        difficulty: Difficulty.easy,
        isCompleted: true,
      ),
      Problem(
        id: 'p22',
        title: 'Merge Sort',
        difficulty: Difficulty.medium,
        isCompleted: true,
      ),
      Problem(
        id: 'p23',
        title: 'Quick Sort',
        difficulty: Difficulty.medium,
        isCompleted: true,
      ),
      Problem(
        id: 'p24',
        title: 'Recursive Bubble Sort',
        difficulty: Difficulty.easy,
        isCompleted: true,
      ),
      Problem(
        id: 'p25',
        title: 'Recursive Insertion Sort',
        difficulty: Difficulty.easy,
        isCompleted: true,
      ),
    ];
  }

  static List<Problem> _step3Problems() {
    return const [
      Problem(
        id: 'p26',
        title: 'Largest Element in Array',
        difficulty: Difficulty.easy,
        isCompleted: true,
      ),
      Problem(
        id: 'p27',
        title: 'Second Largest Element',
        difficulty: Difficulty.easy,
        isCompleted: true,
      ),
      Problem(
        id: 'p28',
        title: 'Check if Array is Sorted',
        difficulty: Difficulty.easy,
        isCompleted: true,
      ),
      Problem(
        id: 'p29',
        title: 'Remove Duplicates from Sorted Array',
        difficulty: Difficulty.easy,
        isCompleted: true,
      ),
      Problem(
        id: 'p30',
        title: 'Left Rotate Array by One',
        difficulty: Difficulty.easy,
        isCompleted: true,
      ),
      Problem(
        id: 'p31',
        title: 'Left Rotate Array by D Places',
        difficulty: Difficulty.medium,
        isCompleted: false,
      ),
      Problem(
        id: 'p32',
        title: 'Move Zeros to End',
        difficulty: Difficulty.easy,
        isCompleted: true,
      ),
      Problem(
        id: 'p33',
        title: 'Union of Two Sorted Arrays',
        difficulty: Difficulty.medium,
        isCompleted: false,
      ),
      Problem(
        id: 'p34',
        title: 'Two Sum',
        difficulty: Difficulty.medium,
        isCompleted: true,
        description:
            'Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target. You may assume that each input would have exactly one solution, and you may not use the same element twice.',
        examples: [
          ProblemExample(
            input: 'Input: nums = [2,7,11,15], target = 9',
            output: 'Output: [0,1]',
            explanation: 'Because nums[0] + nums[1] == 9, we return [0, 1].',
          ),
          ProblemExample(
            input: 'Input: nums = [3,2,4], target = 6',
            output: 'Output: [1,2]',
          ),
        ],
        hints: ['Try using a hash map to store elements you have seen.'],
        companyTags: ['Amazon', 'Google', 'Facebook', 'Apple'],
        practiceOptions: [
          PracticeOption(label: '[0, 1]', isCorrect: true),
          PracticeOption(label: '[1, 2]'),
          PracticeOption(label: '[0, 2]'),
          PracticeOption(label: '[1, 3]'),
        ],
        editorial: EditorialContent(
          videoUrl:
              'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
          approaches: [
            Approach(
              name: 'Brute Force',
              intuition:
                  'Check every pair of elements to see if their sum equals the target.',
              code: '''vector<int> twoSum(vector<int>& nums, int target) {
    for (int i = 0; i < nums.size(); i++) {
        for (int j = i + 1; j < nums.size(); j++) {
            if (nums[i] + nums[j] == target) {
                return {i, j};
            }
        }
    }
    return {};
}''',
              timeComplexity: 'O(n²)',
              spaceComplexity: 'O(1)',
            ),
            Approach(
              name: 'Better (Sorting + Two Pointer)',
              intuition:
                  'Sort the array and use two pointers from both ends. Move the left pointer right if sum is too small, move right pointer left if sum is too large.',
              code: '''vector<int> twoSum(vector<int>& nums, int target) {
    vector<pair<int,int>> arr;
    for (int i = 0; i < nums.size(); i++)
        arr.push_back({nums[i], i});
    sort(arr.begin(), arr.end());
    int lo = 0, hi = arr.size() - 1;
    while (lo < hi) {
        int sum = arr[lo].first + arr[hi].first;
        if (sum == target)
            return {arr[lo].second, arr[hi].second};
        else if (sum < target) lo++;
        else hi--;
    }
    return {};
}''',
              timeComplexity: 'O(n log n)',
              spaceComplexity: 'O(n)',
            ),
            Approach(
              name: 'Optimal (Hash Map)',
              intuition:
                  'Use a hash map to store each element and its index. For each element, check if target - element exists in the map.',
              code: '''vector<int> twoSum(vector<int>& nums, int target) {
    unordered_map<int, int> mp;
    for (int i = 0; i < nums.size(); i++) {
        int complement = target - nums[i];
        if (mp.find(complement) != mp.end()) {
            return {mp[complement], i};
        }
        mp[nums[i]] = i;
    }
    return {};
}''',
              timeComplexity: 'O(n)',
              spaceComplexity: 'O(n)',
            ),
          ],
        ),
      ),
      Problem(
        id: 'p35',
        title: 'Sort an Array of 0s, 1s and 2s',
        difficulty: Difficulty.medium,
        isCompleted: true,
      ),
      Problem(
        id: 'p36',
        title: 'Majority Element (>n/2)',
        difficulty: Difficulty.medium,
        isCompleted: true,
      ),
      Problem(
        id: 'p37',
        title: 'Kadane\'s Algorithm',
        difficulty: Difficulty.medium,
        isCompleted: true,
      ),
      Problem(
        id: 'p38',
        title: 'Stock Buy and Sell',
        difficulty: Difficulty.medium,
        isCompleted: false,
      ),
      Problem(
        id: 'p39',
        title: 'Rearrange by Sign',
        difficulty: Difficulty.medium,
        isCompleted: false,
      ),
      Problem(
        id: 'p40',
        title: 'Next Permutation',
        difficulty: Difficulty.medium,
        isCompleted: true,
      ),
    ];
  }

  static List<Problem> _step4Problems() {
    return const [
      Problem(
        id: 'p41',
        title: 'Binary Search to find X',
        difficulty: Difficulty.easy,
        isCompleted: true,
      ),
      Problem(
        id: 'p42',
        title: 'Lower Bound',
        difficulty: Difficulty.easy,
        isCompleted: true,
      ),
      Problem(
        id: 'p43',
        title: 'Upper Bound',
        difficulty: Difficulty.easy,
        isCompleted: true,
      ),
      Problem(
        id: 'p44',
        title: 'Search Insert Position',
        difficulty: Difficulty.easy,
        isCompleted: true,
      ),
      Problem(
        id: 'p45',
        title: 'Floor and Ceil in Sorted Array',
        difficulty: Difficulty.easy,
        isCompleted: false,
        description:
            'Given a sorted array nums and an integer x. Find the floor and ceil of x in nums. The floor of x is the largest element in the array which is smaller than or equal to x. The ceiling of x is the smallest element in the array greater than or equal to x. If no floor or ceil exists, output -1.',
        examples: [
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
        ],
        hints: ['Think about using binary search to find the position.'],
        companyTags: ['Google', 'Amazon', 'Microsoft'],
        practiceOptions: [
          PracticeOption(label: '[2, 14]'),
          PracticeOption(label: '[-1, 2]', isCorrect: true),
          PracticeOption(label: '[-1, 14]'),
          PracticeOption(label: '[2, -1]'),
        ],
        editorial: EditorialContent(
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
        if (nums[i] <= x) {
            floor = nums[i];
        }
    }
    return floor;
}

int findCeil(vector<int>& nums, int x) {
    int ceil = -1;
    for (int i = 0; i < nums.size(); i++) {
        if (nums[i] >= x) {
            ceil = nums[i];
            break;
        }
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

    // Find floor
    while (lo <= hi) {
        int mid = lo + (hi - lo) / 2;
        if (nums[mid] <= x) {
            floor = nums[mid];
            lo = mid + 1;
        } else {
            hi = mid - 1;
        }
    }

    // Find ceil
    lo = 0; hi = nums.size() - 1;
    while (lo <= hi) {
        int mid = lo + (hi - lo) / 2;
        if (nums[mid] >= x) {
            ceil = nums[mid];
            hi = mid - 1;
        } else {
            lo = mid + 1;
        }
    }

    return {floor, ceil};
}''',
              timeComplexity: 'O(log n)',
              spaceComplexity: 'O(1)',
            ),
          ],
        ),
      ),
      Problem(
        id: 'p46',
        title: 'First and Last Occurrence',
        difficulty: Difficulty.medium,
        isCompleted: true,
      ),
      Problem(
        id: 'p47',
        title: 'Count Occurrences in Sorted Array',
        difficulty: Difficulty.easy,
        isCompleted: true,
      ),
      Problem(
        id: 'p48',
        title: 'Search in Rotated Sorted Array',
        difficulty: Difficulty.medium,
        isCompleted: true,
      ),
      Problem(
        id: 'p49',
        title: 'Minimum in Rotated Sorted Array',
        difficulty: Difficulty.medium,
        isCompleted: true,
      ),
      Problem(
        id: 'p50',
        title: 'Single Element in Sorted Array',
        difficulty: Difficulty.medium,
        isCompleted: false,
      ),
      Problem(
        id: 'p51',
        title: 'Peak Element',
        difficulty: Difficulty.medium,
        isCompleted: false,
      ),
      Problem(
        id: 'p52',
        title: 'Koko Eating Bananas',
        difficulty: Difficulty.hard,
        isCompleted: false,
      ),
    ];
  }

  static List<Problem> _step5Problems() {
    return const [
      Problem(
        id: 'p53',
        title: 'Remove Outermost Parentheses',
        difficulty: Difficulty.easy,
        isCompleted: true,
      ),
      Problem(
        id: 'p54',
        title: 'Reverse Words in a String',
        difficulty: Difficulty.medium,
        isCompleted: true,
      ),
      Problem(
        id: 'p55',
        title: 'Largest Odd Number in String',
        difficulty: Difficulty.easy,
        isCompleted: false,
      ),
      Problem(
        id: 'p56',
        title: 'Longest Common Prefix',
        difficulty: Difficulty.easy,
        isCompleted: false,
      ),
      Problem(
        id: 'p57',
        title: 'Isomorphic Strings',
        difficulty: Difficulty.easy,
        isCompleted: false,
      ),
      Problem(
        id: 'p58',
        title: 'Check if Strings are Rotations',
        difficulty: Difficulty.easy,
        isCompleted: false,
      ),
      Problem(
        id: 'p59',
        title: 'Check Anagram',
        difficulty: Difficulty.easy,
        isCompleted: true,
      ),
      Problem(
        id: 'p60',
        title: 'Sort Characters by Frequency',
        difficulty: Difficulty.medium,
        isCompleted: false,
      ),
    ];
  }
}
