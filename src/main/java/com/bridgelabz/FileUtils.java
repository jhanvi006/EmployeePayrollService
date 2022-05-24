package com.bridgelabz;

import java.io.File;
import java.nio.file.Files;

public class FileUtils {
    public static boolean deleteFiles(File contentToDelete) {
        File[] allContents = contentToDelete.listFiles();
        if (allContents != null){
            for (File file : allContents){
                deleteFiles(file);
            }
        }
        return contentToDelete.delete();
    }
}
