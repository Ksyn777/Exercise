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

