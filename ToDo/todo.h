#include <iostream>
#include <vector>
#include <stdexcept>

using namespace std;

enum Priority { High, Mid, Low};

class TaskException: public runtime_error{
    public:
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
    void display() const;
    void setStatus();
    int getId() const;
    string getDescription() const;
    Priority getPriority() const;
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
    vector<Task>& getTasks(); 
    const vector<Task>& getTasks() const;
    bool addTask(Priority priority);
    bool removeTask(int id);
    static void setNextId(int id);
    void editTask(int id);
    void showAllTasks();
    bool toggleTask(int id);
    void findTasksByTitle(const string& title);
    void sortByPriority();

};

class FileStorage
{
    public: 
    string filename;
    FileStorage(const string& fname) : filename(fname) {}
    void save(const vector<Task>& tasks);
    void load(vector<Task>& tasks);

};