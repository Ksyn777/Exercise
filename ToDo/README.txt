# Simple To-Do List Manager (C++)

This project follows key software engineering principles: DAO for separating data persistence from logic, 
and RAII for robust resource management. By using encapsulation, I ensured that the internal state of the task list is protected, 
while a static member manages unique IDs to maintain data consistency.

 Key Features
- **Persistence:** Save and load tasks from a local file (`tasks.txt`).
- **Smart Sorting:** Tasks are sorted by priority (High > Mid > Low) and alphabetically by title.
- **Error Handling:** Custom exception system (`TaskException`) to prevent crashes on invalid input or file errors.
- **Data Integrity:** Automatic ID synchronization after loading files to prevent duplicate IDs.
- **Search & Filter:** Find tasks by keyword in the title.

Technical Highlights
- **Modern C++:** Extensive use of STL containers (`std::vector`), algorithms (`std::sort`, `std::max_element`), and lambdas.
- **Encapsulation:** Clean class hierarchy with private members and public interfaces (Getters/Setters).
- **File I/O:** Custom parser using `std::stringstream` and pipe-separated values (`|`) for data integrity.
- **Architecture:** Separation of concerns between Data Management (`TodoManager`) and Storage (`FileStorage`).



How to Run
1. Clone the repository.
2. Compile using G++:
   ```bash
   g++ main.cpp todo.cpp -o todo_app