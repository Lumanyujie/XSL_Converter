package com.example.utils;


//import cn.hutool.core.io.FileUtil;
//import cn.hutool.core.io.file.FileAppender;
//import cn.hutool.core.io.file.FileReader;

import com.example.factory.Factory;
import com.example.factory.StrategyFactory;
import com.example.strategy.Strategy;
import com.example.strategy.strategyImpl.DisplayCurTextStrategy;
import com.example.strategy.strategyImpl.FunStrategy;
import com.example.strategy.strategyImpl.ParseColStrategy;
import com.example.strategy.strategyImpl.ProcessBrStrategy;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

/**
 * 转换字符串
 * 通过dom4j遍历xsl的各个节点
 * 转换引用方法的freemarker模板
 */

public class ToFtlUtil {

    public static void main(String[] args) {
        //执行dom4j解析方法
        SAXReader reader = new SAXReader();

        try {
            //读取xml文件
            Document document = reader.read("D:/Develop/IDEA/code_project/XSL_Converter/src/main/resources/msg1000.xsl");
            //得到根节点
            Element rootElement = document.getRootElement();
            //用另一个ftl文件来存储转换后的模板
            String fileName = "D:/Develop/IDEA/code_project/XSL_Converter/src/main/resources/msg1000.ftl";
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

                    //解析process-br
                    ProcessBrStrategy processBrStrategy = new ProcessBrStrategy();
                    processBrStrategy.doOperation(subElement,writer);

                    //用StringBuilder来拼接中间部分
                    StringBuilder midStr = new StringBuilder();
                    String startPath = "";
                    //获取template下的路径值
                    if (subElement.attributeValue("match") != null) {
                        String match = subElement.attributeValue("match");
                        String[] splitMatch = match.split("/");
                        for (String path : splitMatch) {
                            startPath = startPath + path;
                        }
                    }

                    while (iterator.hasNext()) {//遍历template下节点
                        Element next = (Element) iterator.next();

                        //遇见以下节点，直接跳过
                        if (next.getName().equals("call-template")){
                            if (next.attributeValue("name").equals("set-table-status") || next.attributeValue("name").equals("set-table-header")
                                    || next.attributeValue("name").equals("set-caption") || next.attributeValue("name").equals("render-header")
                                    || next.attributeValue("name").equals("render-footer")||next.attributeValue("name").equals("render-body")) {
                                continue;
                            }
                        }

                        //如果子节点为call-template
                        //处理静态方法
                        if (next.getName().equals("call-template") && (!next.attributeValue("name").equals("parse-col"))
                                && (!next.attributeValue("name").equals("display_cur_text"))) {
                            FunStrategy funStrategy = new FunStrategy();
                            funStrategy.doOperation(next, writer);
                        }

                        //解析列
                        ParseColStrategy parseColStrategy = new ParseColStrategy();
                        parseColStrategy.doOperation(next, writer);

                        //display_cur_text
                        DisplayCurTextStrategy displayCurTextStrategy = new DisplayCurTextStrategy();
                        displayCurTextStrategy.doOperation(next, writer);

                        //如果子节点为"text"
                        if (next.getName().equals("text")) {
                            String text = next.getText();//获取文本节点的内容
                            writer.write(text);
                            writer.flush();
                        }

                        //如果子节点为value-of
                        if (next.getName().equals("value-of")) {
                            String text = next.getName();//获取节点的文字
                            //得到子节点及其属性内容
                            String select = next.attributeValue("select");
                            //处理select,去掉分号
                            String[] split = select.split("/");
                            StringBuilder sumPath = new StringBuilder();
                            for (int i = 1; i < split.length; i++) {
                                sumPath.append(split[i]).append("|");
                            }
                            sumPath.deleteCharAt(sumPath.length() - 1);
                            midStr.append(startPath).append(sumPath);
                            String ftlStr = "${" + midStr + "}";
                            writer.write(ftlStr + "\n");
                            writer.flush();
                            midStr.setLength(0);
                        }
                        //如果子节点为variable
//                        if (next.getName().equals("variable")) {
//                            if (next.element("call-template") != null) {
//                                Element funNode = next.element("call-template");
//                                StringBuilder callTemplateParse = callTemplateParse(funNode);
//                                String ftl = "${" + callTemplateParse + "}";
//                                writer.write(ftl + "\n");
//                                writer.flush();
//                            }
//
//                            if (next.attributeValue("select") != null) {
//                                String funName = next.attributeValue("select");
//                                //对每个参数进行判断
//                                String[] split = funName.split(",");
//                                StringBuilder finalFunName = new StringBuilder();
//                                for (int i = 0; i < split.length; i++) {
//                                    //修改占位符，将$改为${}，这里借助队列实现
//                                    if (split[i].contains("$")) {
//                                        Queue<Character> queue = new LinkedList<>();
//                                        //将新的占位符放入队列
//                                        for (int j = 0; j < split[i].length(); j++) {
//                                            if (split[i].charAt(j) == '$') {
//                                                queue.add(split[i].charAt(j));
//                                                queue.add('{');
//                                            } else if (split[i].charAt(j) == ')') {
//                                                queue.add('}');
//                                                queue.add(split[i].charAt(j));
//                                            } else if (j == split[i].length() - 1) {
//                                                queue.add(split[i].charAt(j));
//                                                queue.add('}');
//                                            } else {
//                                                queue.add(split[i].charAt(j));
//                                            }
//                                        }
//                                        //从队列中读取
//                                        int queueLength = queue.size();
//                                        StringBuilder newFunName = new StringBuilder();
//                                        for (int k = 0; k < queueLength; k++) {
//                                            newFunName.append(queue.poll());
//                                        }
//                                        //最后拼接
//                                        if (i == split.length - 1) {
//                                            finalFunName.append(newFunName);
//                                        } else {
//                                            finalFunName.append(newFunName).append(",");
//                                        }
//                                    } else {
//                                        finalFunName.append(split[i]);
//                                    }
//                                }
//                                String ftl = "${" + finalFunName + "}";
//                                writer.write(ftl + "\n");
//                                writer.flush();
//                            }
//                        }

                        //如果子节点为if
                    }
                }

            }
            writer.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }


    /**
     * 处理call-template节点，返回一个完整的方法名和参数
     * 例如：trans_word_FUN(Order,MD@C)
     *
     * @param next
     * @return
     */
//    public static StringBuilder callTemplateParse(Element next) {
//        StringBuilder sb = new StringBuilder();
//
//        if (next.getName().equals("call-template")) {
//            //1.得到节点->得到属性名称
//            String name = next.attributeValue("name");
//            sb.append(name).append("(");//trans_word_FUN(
//            //2.得到子节点的迭代器，进行遍历
//            Iterator<Element> subIterator = next.elementIterator();
//            //如果迭代器为空
//            if (!subIterator.hasNext()) {
//                sb.append(",");
//            }
//            while (subIterator.hasNext()) {
//                Element subNext = subIterator.next();
//                //3.再判断每个子节点中的子节点
//                if (subNext.getName().equals("with-param")) {
//
//                    //如果有值就直接传进去
//                    if (subNext.attributeValue("select") != null) {
//                        String select = subNext.attributeValue("select");
//                        if (select.contains("$")) {
//                            Queue<Character> queue = new LinkedList<>();
//                            //将新的占位符放入队列
//                            for (int i = 0; i < select.length(); i++) {
//                                if (select.charAt(i) == '$') {
//                                    queue.add(select.charAt(i));
//                                    queue.add('{');
//                                } else if (select.charAt(i) == ',' || select.charAt(i) == ')') {
//                                    queue.add('}');
//                                    queue.add(select.charAt(i));
//                                } else if (i == select.length() - 1) {
//                                    queue.add(select.charAt(i));
//                                    queue.add('}');
//                                } else {
//                                    queue.add(select.charAt(i));
//                                }
//                            }
//
//                            int queueLength = queue.size();
//                            for (int i = 0; i < queueLength; i++) {
//                                sb.append(queue.poll());
//                            }
//
//                            sb.append(",");
//                            continue;
//                        }
//                        sb.append(select).append(",");
//                        continue;
//                    }
//
//                    //文本参数
//                    if (subNext.element("text") != null) {
//                        //trans_word_FUN('text',
//                        Element textNode = subNext.element("text");
//                        sb.append("'").append(textNode.getText()).append("'").append(",");
//                    }
//                    //传值参数
//                    if (subNext.element("value-of") != null) {
//                        //trans_word_FUN(MD@C,
//                        //得到子节点及其属性内容
//                        Element valueNode = subNext.element("value-of");
//                        String select = valueNode.attributeValue("select");
//                        //处理select,去掉分号
//                        String[] split = select.split("/");
//                        String sumPath = "";
//                        for (String path : split) {
//                            sumPath = sumPath + path;
//                        }
//                        sb.append(sumPath).append(",");
//                    }
//                }
//            }
//            sb.deleteCharAt(sb.length() - 1);
//            sb.append(")");
//        }
//        return sb;
//    }
//
//    public static StringBuilder placeholderParse(String funName) {
//        String[] split = funName.split(",");
//        StringBuilder finalFunName = new StringBuilder();
//        for (int i = 0; i < split.length; i++) {
//            //修改占位符，将$改为${}，这里借助队列实现
//            if (split[i].contains("$")) {
//                Queue<Character> queue = new LinkedList<>();
//                //将新的占位符放入队列
//                for (int j = 0; j < split[i].length(); j++) {
//                    if (split[i].charAt(j) == '$') {
//                        queue.add(split[i].charAt(j));
//                        queue.add('{');
//                    } else if (split[i].charAt(j) == ')') {
//                        queue.add('}');
//                        queue.add(split[i].charAt(j));
//                    } else if (j == split[i].length() - 1) {
//                        queue.add(split[i].charAt(j));
//                        queue.add('}');
//                    } else {
//                        queue.add(split[i].charAt(j));
//                    }
//                }
//                //从队列中读取
//                int queueLength = queue.size();
//                StringBuilder newFunName = new StringBuilder();
//                for (int k = 0; k < queueLength; k++) {
//                    newFunName.append(queue.poll());
//                }
//                //最后拼接
//                if (i == split.length - 1) {
//                    finalFunName.append(newFunName);
//                } else {
//                    finalFunName.append(newFunName).append(",");
//                }
//            } else {
//                finalFunName.append(split[i]);
//            }
//        }
//        return finalFunName;
//    }
}
