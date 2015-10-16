package com.d1.search;

import java.io.File;

public class FileUtil {
	/**
	 * µÝ¹éÉ¾³ýÒ»¸öÄ¿Â¼
	 * @param delpath
	 * @throws FileNotFoundException
	 * @throws IOException
	 */
	public static void deleteDir(File delpath) {
		File[] filelist = delpath.listFiles();
		if (filelist != null && filelist.length != 0) {
			for (int i = 0; i < filelist.length; i++) {
				if (filelist[i].isDirectory()) {
					deleteDir(filelist[i]);
				} else {
					filelist[i].delete();
				}
			}
			delpath.delete();
		} else {
			delpath.delete();
		}
	}
}
