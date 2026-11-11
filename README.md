# Smart Scheduler Suite

A desktop application (C++17, Qt Widgets) that automates four kinds of planning:
a **Timetable Builder**, a **Tournament Generator**, a **Study Planner** and an **Event Planner**.
It works offline. All algorithms use our own data structure library; Qt is used only for the interface.

![Timetable](docs/timetable.png)   <!-- one screenshot per module -->

## Features
- Timetable Builder: clash-free timetables by backtracking, ranked by score (gaps, free days, early classes, days on campus), filters, locked sections, Prev/Next navigation
- Tournament Generator: round-robin (circle method, byes for odd n) and knockout (binary tree, seeding, byes, enter results, winners advance)
- Study Planner: day-by-day plan from deadlines and difficulty, with warnings for topics that do not fit
- Event Planner: topological order of tasks, earliest start times, double-booking detection
- Save/load (JSON), CSV import, export to PNG/PDF, dark mode

## Build
Requirements: Qt 6.x, CMake 3.21+, a C++17 compiler (MinGW or MSVC).
    cmake -S . -B build -DCMAKE_BUILD_TYPE=Release
    cmake --build build
    build/SmartScheduler
Tests (no Qt needed): `cd build && ctest --output-on-failure`

## Data structures and where they are used
| Course topic | File | Used for |
|---|---|---|
| Dynamic safe array | core/ds/DynArray.h | every list in the engine (bounds-checked at()) |
| Linked list | core/ds/LinkedList.h | sections of a course, Prev/Next over results, hash-table buckets |
| Stack | core/ds/Stack.h | partial timetable during backtracking |
| Queue | core/ds/Queue.h | round-robin rotation, building the knockout levels, Kahn's algorithm |
| Recursion / backtracking | engine/TimetableSolver.cpp | exploring section combinations |
| Sorting (6 algorithms) | core/algo/Sorting.h | ranking timetables, day order, start-time sweep |
| Heap / priority queue | core/ds/MinHeap.h | best K timetables, most urgent study topic |
| Binary tree | core/model/Bracket.h | knockout bracket, winners move to the parent |
| Hashing | core/ds/HashTable.h | locked sections, course codes, task id lookup |
| Graph | core/ds/Graph.h | section conflict graph, task dependency graph |

Not implemented (optional in the proposal): binary search tree, string search, undo/redo, points table.

## Tests
`tests/` contains unit tests for every structure and sort, a brute-force cross-check of the timetable solver on 300 random inputs, tournament invariants for 2 to 32 teams, and tests for both planners.

## Example data
`data/example_courses.csv`, `data/example_teams.csv`, or Help > Load example.

## Authors
Muhammed Ahmed Ashfaq (25K-0781), Fahad-ul-Islam (25K-0531), Moazamuddin (25K-0771), BCS-3E, FAST-NUCES Karachi.

# Smart Scheduler Suite — Hero Landing GUI

The application opens on a product overview / hero landing page. No planning module opens automatically. From the overview, users can choose Timetable Generator or Event Planner. The sidebar includes Overview navigation. Timetable Generator remains the first planning module; Event Planner is second. Existing scheduling engines and data-entry workflows are retained.
