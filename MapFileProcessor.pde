import java.util.Stack;

class MapFileProcessor
{
    String mapFilePath;
    String mapFileLines[];

    boolean fileLoaded, fileValidated;

    ArrayList<Entity> entityList;

    //Empty constructor
    MapFileProcessor() { entityList = new ArrayList<Entity>(); }

    //Prints the path of the map file
    String mapPath()
    {
        return mapFilePath;
    }

    //Takes care of loading the file, calling a validating helper method, and writing the array of lines
    void loadFile(String path)
    {
        mapFilePath = path;
        fileLoaded = true;
        mapFileLines = loadStrings(mapFilePath);

        validateFile();
    }

    //Make sure that the input file is a valid map file
    void validateFile()
    {
        //Check that the file path shows the correct file extension
        if (mapFilePath.substring(mapFilePath.length() - 4).equals(".map"))
        {
            //Check that the map file actually comes from a Trenchbroom Quake map file
            if (mapFileLines[0].equals("// Game: Quake"))
            {
                fileValidated = true;
            }
        }
    }
    
    //Will call helper methods to scan the file and collect information
    void processMapFile()
    {
        entityScan();
    }

    //Scans the file for entities, creates the entity objects, and adds them to the list
    void entityScan()
    {
        //Intitalize two integers that will determine the start and end of an entity block
        int entityStart = 0;
        int entityEnd = 0;

        //Initialize a stack that will be used to determine when an entity ends
        Stack entityCurlyStack = new Stack();

        //This loop scans through all the lines of the map file top to bottom
        for (int i = 0; i < mapFileLines.length; i++)
        {
            Entity tempEntity;

            //This is how you determine the start of an entity block
            if (mapFileLines[i].equals("{") && mapFileLines[i - 1].contains("// entity"))
            {
                //Record the line in which the entity starts
                entityStart = i + 1;
                //Push a curly to the stack
                entityCurlyStack.push(i);
            }

            //Any curly openings need to be pushed to the stack
            else if (mapFileLines[i].equals("{"))
            {
                entityCurlyStack.push(i);
            }

            //Any curly closes need to cause a stack pop
            else if (mapFileLines[i].equals("}"))
            {
                entityCurlyStack.pop();

                //Check if the pop made the stack empty, which means you reached the end of an entity block
                if (entityCurlyStack.empty())
                {
                    //Record the line in which the entity ends
                    entityEnd = i;

                    //Calculate the length of the entity block
                    int entityBlockLength = entityEnd - entityStart;

                    //println(entityBlockLength);


                    //String entityLines[] = new String[entityBlockLength];

                    //int copyLocation = entityStart;

                    // for (int j = 0; j < entityLines.length; j++)
                    // {
                    //     entityLines[j] = mapFileLines[copyLocation];
                    //     copyLocation++;
                    // }

                    //tempEntity = new Entity(entityLines);
                    //entityList.add(tempEntity);
                }
            }
        }
        
        //entityList.get(1).printLines();
    }
}
