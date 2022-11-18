package com.example.utils;


import cn.hutool.core.io.FileUtil;
import cn.hutool.core.io.file.FileAppender;
import cn.hutool.core.io.file.FileReader;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.util.Iterator;
import java.util.List;

/**
 * 转换字符串
 * 通过dom4j遍历xsl的各个节点
 * TODO:转换引用方法的freemarker模板
 */

public class ToFtlUtil {

    public static void main(String[] args) {
        //执行dom4j解析方法
        SAXReader reader = new SAXReader();

        try {
            //读取xml文件
            Document document = reader.read("D:/Develop/IDEA/code_project/XSL_Converter/src/main/resources/sub1010.xsl");
            //得到根节点
            Element rootElement = document.getRootElement();
            //用另一个ftl文件来存储转换后的模板
            String fileName = "D:/Develop/IDEA/code_project/XSL_Converter/src/main/resources/sub1010.ftl";
            File ftlFile = new File(fileName);
            FileOutputStream fileOutputStream = new FileOutputStream(ftlFile);
            OutputStreamWriter writer = new OutputStreamWriter(fileOutputStream);

            Iterator rootElementIterator = rootElement.elementIterator();

            while (rootElementIterator.hasNext()) {
                Element subElement = (Element) rootElementIterator.next();

                //结点为template
                if (subElement.getName().equals("template")) {
                    //获取根节点下的所有xsl:template结点
                    Iterator iterator = subElement.elementIterator();
                    String match = subElement.attributeValue("match");
                    String[] split = match.split("/");
                    //用StringBuilder来拼接中间部分
                    StringBuilder midStr = new StringBuilder();
                    for (int i = 0; i < split.length; i++) {
                        midStr.append(split[i]).append(".");
                    }
                    while (iterator.hasNext()) {//遍历template下节点
                        Element next = (Element) iterator.next();

                        //如果子节点为call-template
                        if (next.getName().equals("call-template")){
                            //1.得到方法名字,类名暂时不用管，测试时再看
                            //2.得到子节点的迭代器，进行遍历
                            //3.再判断每个子节点中的子节点

                        }

                        //如果子节点为"text"
                        if (next.getName().equals("text")){
                            String text = next.getName();//获取节点的文字
                            String ftlStr = "${doc" + midStr + text + "}";
                            writer.write(ftlStr);
                            writer.flush();
                        }
                    }
                }

            }
            writer.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

}
