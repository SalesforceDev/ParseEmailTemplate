# MergeFields

## Why do you want to use it?

1. The salesforce standard email template only merge object itself fields, can't do merge parent fields. The MergeFields class can do this.
2. If we want to send the email using apex code, and the client want to use email template. So we must be use setTargetObjectId method in our apex code, however, we don't want to use it. So we need to parse the email template using MergeFields class.

## How to use MergeFields Class?
Please see the code below, you only need to call it in your apex code. So easy.
```java
Map<Id, String> objectIdToContent = MergeFields.parse(ids, content);
```

#### Object parameter description
Set<Id> ids -> record ids
String content -> email template body

#### Parsing the text content

```java
EmailTemplate templateObj = [select Body from EmailTemplate where DeveloperName = 'Test01'];
Set<Id> contacts = new Set<Id>;
for(Contact con : [select Id from Contact limit 100])
{
	contacts.add(con.Id);
}
Map<Id, String> objectIdToContent = MergeFields.parse(contacts, templateObj.Body)
```
#### Parsing the HTML content
```java
EmailTemplate templateObj = [select HTMLValue from EmailTemplate where DeveloperName = 'Test01'];
Set<Id> contacts = new Set<Id>;
for(Contact con : [select Id from Contact limit 100])
{
	contacts.add(con.Id);
}
Map<Id, String> objectIdToContent = MergeFields.parse(contacts, templateObj.HTMLValue);
```
## Installation
This is a Unmanaged package, please see the installation url below.
https://login.salesforce.com/packaging/installPackage.apexp?p0=04ti00000011RRj

## Donation
If this project help you reduce time to develop, you can give me a cup of coffee :) 

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=R97DS5932HEZS)