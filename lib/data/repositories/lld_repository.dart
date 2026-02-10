import '../models/topic.dart';
import '../models/course.dart';

class LldRepository {
  static Course getCourse() {
    return const Course(
      id: 'lld',
      title: 'Low Level Design',
      subtitle: 'Learn LLD and Design Patterns',
      iconName: 'design',
      colorValue: 0xFFE2703A,
      progress: 0.12,
      totalTopics: 20,
      completedTopics: 2,
    );
  }

  static List<Topic> getTopics() {
    return const [
      Topic(
        id: 'lld1',
        title: 'SOLID Principles',
        description:
            'Learn the five SOLID principles of object-oriented design:\n\n'
            '• Single Responsibility Principle\n'
            '• Open/Closed Principle\n'
            '• Liskov Substitution Principle\n'
            '• Interface Segregation Principle\n'
            '• Dependency Inversion Principle\n\n'
            'These principles form the foundation of clean, maintainable code.',
        totalProblems: 5,
        completedProblems: 3,
      ),
      Topic(
        id: 'lld2',
        title: 'Design Patterns - Creational',
        description:
            'Master creational design patterns:\n\n'
            '• Singleton Pattern\n'
            '• Factory Method Pattern\n'
            '• Abstract Factory Pattern\n'
            '• Builder Pattern\n'
            '• Prototype Pattern\n\n'
            'These patterns deal with object creation mechanisms.',
        totalProblems: 5,
        completedProblems: 2,
      ),
      Topic(
        id: 'lld3',
        title: 'Design Patterns - Structural',
        description:
            'Learn structural design patterns:\n\n'
            '• Adapter Pattern\n'
            '• Decorator Pattern\n'
            '• Facade Pattern\n'
            '• Proxy Pattern\n'
            '• Composite Pattern\n\n'
            'These patterns deal with object composition.',
        totalProblems: 5,
        completedProblems: 0,
      ),
      Topic(
        id: 'lld4',
        title: 'Design Patterns - Behavioral',
        description:
            'Master behavioral design patterns:\n\n'
            '• Observer Pattern\n'
            '• Strategy Pattern\n'
            '• Command Pattern\n'
            '• State Pattern\n'
            '• Template Method Pattern\n\n'
            'These patterns deal with communication between objects.',
        totalProblems: 5,
        completedProblems: 0,
      ),
      Topic(
        id: 'lld5',
        title: 'Design Parking Lot System',
        description:
            'Design a parking lot system with the following requirements:\n\n'
            '• Multiple floors with different spot sizes\n'
            '• Vehicle types: Car, Bike, Truck\n'
            '• Entry/Exit gates with ticket system\n'
            '• Payment calculation based on duration\n'
            '• Display board showing available spots\n\n'
            'Focus on class design, interfaces, and SOLID principles.',
        totalProblems: 1,
        completedProblems: 0,
      ),
      Topic(
        id: 'lld6',
        title: 'Design Tic Tac Toe',
        description:
            'Design a Tic Tac Toe game:\n\n'
            '• N x N board support\n'
            '• Two players (X and O)\n'
            '• Win detection (rows, cols, diagonals)\n'
            '• Draw detection\n'
            '• Undo move support\n\n'
            'Implement using clean OOP principles.',
        totalProblems: 1,
        completedProblems: 0,
      ),
      Topic(
        id: 'lld7',
        title: 'Design BookMyShow',
        description:
            'Design a movie ticket booking system:\n\n'
            '• Browse movies and shows\n'
            '• Select theater and showtime\n'
            '• Seat selection with availability\n'
            '• Payment and booking confirmation\n'
            '• Cancellation and refund\n\n'
            'Handle concurrent booking scenarios.',
        totalProblems: 1,
        completedProblems: 0,
      ),
      Topic(
        id: 'lld8',
        title: 'Design Elevator System',
        description:
            'Design an elevator system for a building:\n\n'
            '• Multiple elevators\n'
            '• Optimal elevator assignment\n'
            '• Direction-based scheduling\n'
            '• Emergency stop support\n'
            '• Floor request handling\n\n'
            'Focus on scheduling algorithms and state management.',
        totalProblems: 1,
        completedProblems: 0,
      ),
      Topic(
        id: 'lld9',
        title: 'Design Snake and Ladder',
        description:
            'Design the classic Snake and Ladder game:\n\n'
            '• Configurable board size\n'
            '• Multiple players\n'
            '• Dice rolling mechanics\n'
            '• Snake and ladder placement\n'
            '• Win condition detection',
        totalProblems: 1,
        completedProblems: 0,
      ),
      Topic(
        id: 'lld10',
        title: 'Design ATM Machine',
        description:
            'Design an ATM machine system:\n\n'
            '• Card authentication\n'
            '• Balance inquiry\n'
            '• Cash withdrawal with denomination\n'
            '• Cash deposit\n'
            '• Transaction history\n'
            '• Chain of Responsibility for dispensing',
        totalProblems: 1,
        completedProblems: 0,
      ),
    ];
  }
}
