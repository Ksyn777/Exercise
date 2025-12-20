#include <iostream>
#include <string>
#include <limits>
#include "todo.h"

using namespace std;

void printMenu() {
    cout << "\n========== TODO LIST MANAGER ==========" << endl;
    cout << "1. Display all tasks" << endl;
    cout << "2. Add a new task" << endl;
    cout << "3. Toggle task status (Done/Todo)" << endl;
    cout << "4. Remove a task" << endl;
    cout << "5. Edit a task" << endl;
    cout << "6. Search by title" << endl;
    cout << "7. Sort by priority" << endl;
    cout << "0. Save and Exit" << endl;
    cout << "=======================================" << endl;
    cout << "Your choice: ";
}

int main() {
    TodoManager manager;
    FileStorage storage("tasks.txt");

    // 1. Ładowanie danych przy starcie
    try {
        storage.load(manager.getTasks());
        cout << ">>> Data loaded from file successfully." << endl;
    } catch (const TaskException& e) {
        cout << ">>> Notice: " << e.what() << " (Starting with new file)" << endl;
    }

    int choice;
    bool running = true;

    while (running) {
        printMenu();
        
        // Zabezpieczenie przed wpisaniem tekstu zamiast liczby
        if (!(cin >> choice)) {
            cin.clear();
            cin.ignore(numeric_limits<streamsize>::max(), '\n');
            cout << "Invalid input! Please enter a number." << endl;
            continue;
        }
        cin.ignore(numeric_limits<streamsize>::max(), '\n'); // Wyczyszczenie bufora

        try {
            switch (choice) {
                case 1:
                    manager.showAllTasks();
                    break;

                case 2: {
                    int p;
                    cout << "Choose priority (0-High, 1-Mid, 2-Low): ";
                    cin >> p;
                    cin.ignore(numeric_limits<streamsize>::max(), '\n');
                    
                    if (p < 0 || p > 2) throw TaskException("Invalid priority range!");
                    
                    manager.addTask(static_cast<Priority>(p));
                    cout << "Task added successfully." << endl;
                    break;
                }

                case 3: {
                    int id;
                    cout << "Enter task ID to toggle: ";
                    cin >> id;
                    if (manager.toggleTask(id)) {
                        cout << "Status changed successfully." << endl;
                    }
                    break;
                }

                case 4: {
                    int id;
                    cout << "Enter task ID to remove: ";
                    cin >> id;
                    cin.ignore(); // Czyszczenie przed pytaniem 'yes/no' wewnątrz removeTask
                    if (manager.removeTask(id)) {
                        cout << "Task deleted." << endl;
                    } else {
                        cout << "Deletion canceled or task not found." << endl;
                    }
                    break;
                }

                case 5: {
                    int id;
                    cout << "Enter task ID to edit: ";
                    cin >> id;
                    cin.ignore();
                    manager.editTask(id);
                    break;
                }

                case 6: {
                    string query;
                    cout << "Enter title to search: ";
                    getline(cin, query);
                    manager.findTasksByTitle(query);
                    break;
                }

                case 7:
                    manager.sortByPriority();
                    cout << "Tasks sorted by priority." << endl;
                    manager.showAllTasks();
                    break;

                case 0:
                    storage.save(manager.getTasks());
                    running = false;
                    cout << "Goodbye!" << endl;
                    break;

                default:
                    cout << "Option not recognized. Try again." << endl;
                    break;
            }
        } catch (const TaskException& e) {
            cout << "--- APP ERROR: " << e.what() << " ---" << endl;
        }
    }

    return 0;
}