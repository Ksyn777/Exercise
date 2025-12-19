#include <iostream>

using namespace std;

class Task 
{
    private:
    int id;
    enum Priority { High, Mid, Low};
    string description;
    Priority priority;
    bool status;
    public:
    Task(int i, string desc, Priority prio, bool st) :id(i), description(desc), priority(prio), status(st) {};
    bool addTask();
    bool removeTask(int id);
    void showAllTasks();
    void markADone();
    void display();
    void getTask(int id);
};

