@isTest
public class TestMergeFields
{
    @isTest
    public static void testMergeContent()
    {
        Contact con = new Contact(LastName = 'Test');
        insert con;
        Map<Id, String> contactMap = new Map<Id, String>();
        contactMap.put(con.Id, 'Hello {!Contact.LastName}');
        System.assert(MergeFields.parse(contactMap).get(con.Id) == 'Hello Test');
    }
}