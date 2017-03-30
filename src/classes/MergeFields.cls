public class MergeFields
{
    public static Map<Id, String> parse(Map<Id, String> objectIdToContent)
    {
        Set<String> allApis = new Set<String>();
        String objectAPI = '';
        for(Id objId : objectIdToContent.keySet())
        {
            objectAPI = getObjectAPI(objId);
            allApis.addAll(getFields(objectIdToContent.get(objId), objectAPI));
        }
        String objectFields = '';
        for(String field : allApis)
        {
            objectFields += field + ', ';
        }
        if(objectFields != '')
        {
            Map<Id, String> objectIdToNewContent = new Map<Id, String>();
            objectFields = objectFields.substring(0, objectFields.length() - 2);
            Set<Id> objectIds = objectIdToContent.keySet();
            String queryStr = 'select ' + objectFields + ' from ' + objectAPI + ' where Id in :objectIds';
            Map<String, String> tempMap = new Map<String, String>();
            for(sObject obj : Database.query(queryStr))
            {
                for(String field : allApis)
                {
                    tempMap.put(field, String.valueOf(getFieldValue(obj, field)));
                }

                objectIdToNewContent.put(obj.Id, match(objectIdToContent.get(obj.Id), tempMap, objectAPI));
            }

            return objectIdToNewContent;
        }

        return objectIdToContent;
    }

    public static Object getFieldValue(SObject entity, String fieldName)
    {
        if(entity == null)
        {
            return null;
        }

        if(fieldName.contains('.'))
        {
            return getFieldValue(entity.getSObject(fieldName.substringBefore('.')), fieldName.substringAfter('.'));
        }
        else
        {
            return entity.get(fieldName);
        }
    }

    private static Set<String> getFields(String content, String objectAPI)
    {
        Set<String> fieldApis = new Set<String>();
        Matcher m = Pattern.compile('(\\{!\\s*' + objectAPI + '\\.([A-Za-z\\._0-9]+)\\s*\\})').matcher(content);
        Set<String> matchFields = new Set<String>();
        while(m.find())
        {
            String merge_field = m.group(2);
            fieldApis.add(merge_field);
        }

        return fieldApis;
    }

    private static String match(String content, Map<String, String> obj, String objectAPI)
    {
        Matcher m = Pattern.compile('(\\{!\\s*' + objectAPI + '\\.([A-Za-z\\._0-9]+)\\s*\\})').matcher(content);
        Set<String> matchFields = new Set<String>();
        while(m.find())
        {
            String merge_field = (String)m.group(0);
            String field = (String)m.group(2);

            String value;
            try
            {
                value = (String)obj.get(field);
            }
            catch(Exception e)
            {
                value = '';
            }
            if(value != null)
            {
                content = content.replace(merge_field, value);
            }
            else
            {
                content = content.replace(merge_field, '');
            }
        }

        return content;
    }

    private static String getObjectAPI(String recordId)
    {
        String keyCode  = recordId.subString(0,3);
        Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
        for(Schema.SObjectType objectInstance : gd.values())
        {
            if(objectInstance.getDescribe().getKeyPrefix() == keyCode)
            {
                return objectInstance.getDescribe().getName();
            }
        }
        return null;
    }
}