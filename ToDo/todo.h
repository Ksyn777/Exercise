#include <iostream>
#include <vector>

using namespace std;

enum Priority { High, Mid, Low};

class TaskException: public runtime_error{
    TaskException(const string& message) : runtime_error(message) {}
};

class Task 
{
    
    private:
    int id;
    string title;
    string description;
    Priority priority;
    bool status;
    public:
    Task(int i, string ti, string desc, Priority prio, bool st = false) :id(i), title(ti), description(desc), priority(prio), status(st) {};
    void display(int id) const;
    int getId() const;
    string getTitle() const;
    bool isCompleted() const;
    void setTitle(int id);
    void setDescription(int id);
};

class TodoManager
{
    private:
    static int nextId;
    vector<Task> tasks;
    public:
    bool addTask(Priority priority);
    bool removeTask(int id);
    void editTask(int id);
    void showAllTasks();
    void toggleTask(int id);
    void findTasksByTitle(const string& title);
    void sortByPriority();

};

class FileStorage
{
    public: 
    string filename;
    void save(const vector<Task>& tasks);
    void load(vector<Task>& tasks);

};