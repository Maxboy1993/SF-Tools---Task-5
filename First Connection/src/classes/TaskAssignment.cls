/**
 * Created by User on 11.09.2020.
 */

public with sharing class TaskAssignment {
    @InvocableMethod(label='Assign Task' category='Account')
    public static void assignTask(List<variables> vars) {
        List<Task> accountLinkedTasks = new List<Task>();
        List<User> users = [SELECT Id FROM User WHERE IsActive = TRUE];
        List<Id> accountsId = new List<Id>();
        for (variables var : vars) {
            accountsId.add(var.Id);
        }
        List<Account> accounts = [SELECT Id, (SELECT WhatId, OwnerId FROM Tasks) FROM Account WHERE Id IN :accountsId];

        for (Account acc : accounts) {
            List<Task> tasks = acc.Tasks;
            if (tasks.size() > 3) {
                accountLinkedTasks.add(tasks);
                Integer userNumber = Integer.valueOf((Math.random() * users.size() - 1));
                for (Task t : tasks) {
                    t.OwnerId = users.get(userNumber).Id;
                }
            }
        }
        update accountLinkedTasks;
    }

public class variables {
@InvocableVariable(required=true)
public String Id;
}
}