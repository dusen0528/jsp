package com.nhnacademy.jsp;

import java.io.Serializable;
import org.jsoup.Jsoup;

public class HtmlBeautifier implements Serializable {

    public HtmlBeautifier(){

    }

    private String html;

    public String getHtml(){
        return Jsoup.parse(this.html).html();
    }

    public void setHtml(String html){
        this.html = html;
    }
}
