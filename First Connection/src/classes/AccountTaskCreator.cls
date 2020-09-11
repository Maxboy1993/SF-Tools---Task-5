/**
 * Created by User on 09.09.2020.
 */

public with sharing class AccountTaskCreator {

    @InvocableMethod(label='Creat Task' category='Account')
    public static void createTask(List<variables> vars) {
        Id accountId = vars[0].Id;
        String accountName = vars[0].Name;

            Task createdTask = new Task();
            createdTask.WhatId = accountId;
            createdTask.Subject = 'Negotiations with ' + accountName;
            insert createdTask;
    }

    public class variables {
        @InvocableVariable(required=true)
        public String Id;
        @InvocableVariable(required=true)
        public String Name;
    }

}




