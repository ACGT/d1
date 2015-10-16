package com.d1.test;

import java.io.IOException;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;

import org.apache.http.entity.ContentProducer;

public class MyContentProducer implements ContentProducer {
	
	private String content;
	public MyContentProducer(String content){
		this.content =content ;
	}

	@Override
	 public void writeTo(OutputStream outstream) throws IOException {
        Writer writer = new OutputStreamWriter(outstream, "UTF-8");
        writer.write(content);
        writer.flush();
        writer.close();
    }

}
