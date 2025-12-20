#include <iostream>
#include <vector>
#include <algorithm>
#include "todo.h"
#include <string>
#include <fstream>
#include <sstream>
#include <stdexcept>


using namespace std;

int TodoManager::nextId = 0;

void Task::setTitle(int id)
{
    string newTitle;
    cout<<"Enter new title: ";
    getline(cin, newTitle);
    if(newTitle.empty())
    {
        throw TaskException("Title cannot be empty");
    }
    cout<<"You change title: "<<newTitle<<endl;
}

void Task::setDescription(int id)
{
    string newDescription;
    cout<<"Enter new Description: ";
    getline(cin, newDescription);
    if(newDescription.empty())
    {
        throw TaskException("Description cannot be empty");
    }
    cout<<"You change description: "<<newDescription<<endl;

}
int Task::getId() const
{
    return id;
}

string Task::getDescription() const{
    return description;
}

Priority Task::getPriority() const{
    return priority;
}

string Task::getTitle() const
{
    return title;
}

bool Task::isCompleted() const
{
    if(status == true)
        return true;
    else
        return false;
}

void Task::display(int id) const
{
    int prio = priority;
    cout<<"ID: "<<id<<endl;
    cout<<"Title: "<<title<<endl;
    cout<<"Description: "<<description<<endl;
    switch (prio)
    {
    case 0:
        cout<<"Priority: High"<<endl;
        break;
    case 1:
         cout<<"Priority: Mid"<<endl; 
    case 2:
        cout<<"Priority: LOW"<<endl;
    default:
        break;
    }
    if(isCompleted() == false)
        cout<<"Status: X"<<endl;
    else
        cout<<"Status: Done!"<<endl;

}

void TodoManager::setNextId(int id)
{
    nextId = id;
}

bool TodoManager::addTask(Priority priority)
{
    string title, description;
    cout<<"Set title: ";
    getline(cin, title);

    cout<<"Set description: ";
    getline(cin, description);

    if(title.empty())
    {
       throw TaskException("Title cannot be empty!");
    }

    if(description.empty())
    {
        throw TaskException("Description cannot be empty!");
    }

    int id = nextId++;

    tasks.emplace_back(id, title, description, priority, false);
    
    return true;
         
}

bool TodoManager::removeTask(int id)
{
    for(auto it = tasks.begin(); it != tasks.end(); ++it)
    {
        if(it->getId() == id)
        {
            cout<<"Found task: "<<it->getTitle()<<"do you watn remove it ?"<<endl;
            string answer;
            getline(cin, answer);
            transform(answer.begin(), answer.end(), answer.begin(), ::tolower);
            if(answer != "yes")
            {
                return false;
            }
            tasks.erase(it);
            return true;
        }
    }
    return false;
}

void TodoManager::editTask(int id)
{
    for(auto it = tasks.begin(); it != tasks.end(); ++it)
    {
        
        if(it->getId() == id)
        {
            cout<<"Found task: "<<it->getTitle()<<"do you watn remove it ?"<<endl;
            string answer;
            getline(cin, answer);
            transform(answer.begin(), answer.end(), answer.begin(), ::tolower);
            if(answer != "yes")
            {
                it->setTitle(id);
                it->setDescription(id);
                cout<<"Task edited successfully."<<endl;
            }
        }
        else
        {
            throw TaskException("Task with given ID not found!");
        }
    }
}

void TodoManager::showAllTasks()
{
    for(const auto& task : tasks)
    {
        task.display(task.getId());
        cout<<"---------------------"<<endl;
    }
}

bool TodoManager::toggleTask(int id)
{
    for(auto& task : tasks)
    {
        if(task.getId() == id)
        {
            if(task.isCompleted() == false)
            {
                cout<<"Marking task as completed."<<endl;
                task = Task(task.getId(), task.getTitle(), task.getDescription(), task.getPriority(), true);
                return true;
            }
        }
        else 
        {
            throw TaskException("Task with given ID not exist!");
            return false;
        }
    }
}

void TodoManager::findTasksByTitle(const string& title)
{
    for(const auto& task : tasks)
    {
        if(task.getTitle().find(title) != string::npos)
        {
            task.display(task.getId());
            cout<<string(20, '-')<<endl;
        }
        else 
        {
            throw TaskException("To tasks with given title found!");
        }
    }
}

void TodoManager::sortByPriority()
{
    sort(tasks.begin(), tasks.end(), [](const Task& a, const Task& b)
    {
        if(a.getPriority() != b.getPriority())
            return a.getPriority() < b.getPriority();
        else 
            return a.getTitle() < b.getTitle();
    });         
}

void FileStorage::save(const vector<Task>& tasks)
{
    ifstream check("tasks.txt");
    if(!check)
    {
        throw TaskException("File not found");    
    }
    check.close();
    
    ofstream(filename);
    filename.open("tasks.txt", ios::out | ios::app);
    if(!filename.is_open())
    {
        throw TaskException("Could not open file for writing!");
    }
    for(auto& task : tasks)
    {
        filename<<task.getId()<<"| "<<task.getTitle()<<"| "<<task.getDescription()<<"| "<<task.getPriority()<<"| "<<task.isCompleted()<<endl;
    }
    if(filename.fail())
    {
        throw TaskException("Error occured while writing to file!");
    }
    else if(filename.goodbit())
    {
        cout<<"Tasks saved successfully to file."<<endl;
    }
    filename.close();
}

void FileStorage::load(vector<Task>& tasks)
{
    tasks.clear();
    ifstream filename("tasks.txt");
    if(!filename.is_open())
    {
        throw TaskException("Could not open file for reading!");
    }
    else
    {
        string line;
        while(getline(filename, line))
        if(line.empty())
            continue;
        else 
        {
            stringstream ss(line);
            string idStr, title, description, priorityStr, statusStr;
            getline(ss, idStr, '|');
            getline(ss, title, '|');
            getline(ss, description, '|');
            getline(ss, priorityStr, '|');
            getline(ss, statusStr);
            tasks.push_back(Task(stoi(idStr), title, description, static_cast<Priority>(stoi(priorityStr)), statusStr == "1"));
            if(!tasks.empty())
            {
                int max_id = max_element(tasks.begin(), tasks.end(), [](const Task& a, const Task& b)
                {
                    return a.getId() < b.getId();
                })->getId();
                TodoManager::setNextId(max_id + 1);
            }
        }
    }
}