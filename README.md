# MergeFields

## Why do you want to use it?

## How to use MergeFields class?

Parse Email Template with type = Text

```java
EmailTemplate templateObj = [select Body from EmailTemplate where DeveloperName = 'Test01'];
Set<Id> contacts = new Set<Id>;
for(Contact con : [select Id from Contact limit 100])
{
	contacts.add(con.Id);
}
Map<Id, String> result = MergeFields.parse(contacts, templateObj.Body)
```
Parse Email Template with type = HTML
```java
EmailTemplate templateObj = [select HTMLValue from EmailTemplate where DeveloperName = 'Test01'];
Set<Id> contacts = new Set<Id>;
for(Contact con : [select Id from Contact limit 100])
{
	contacts.add(con.Id);
}
Map<Id, String> result = MergeFields.parse(contacts, templateObj.HTMLValue);

## Donation
If this project help you reduce time to develop, you can give me a cup of coffee :) 

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=R97DS5932HEZS)