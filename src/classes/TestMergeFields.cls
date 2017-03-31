@isTest
public class TestMergeFields
{
    @isTest
    public static void testMergeContent()
    {
        Contact con = new Contact(LastName = 'Test');
        insert con;
        Set<Id> contacts = new Set<Id>();
        contacts.add(con.Id);
        System.assert(MergeFields.parse(contacts, 'Hello {!Contact.LastName}').get(con.Id) == 'Hello Test');
    }
}