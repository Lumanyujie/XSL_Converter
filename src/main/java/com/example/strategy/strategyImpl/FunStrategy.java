package com.example.strategy.strategyImpl;

import com.example.strategy.Strategy;
import org.dom4j.Element;
import org.springframework.stereotype.Component;

import java.io.Writer;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.Queue;

/**
 * 普通方法调用转换
 */
@Component
public class FunStrategy implements Strategy {

    @Override
    public void doOperation(Element next, Writer writer) {

        try {
            StringBuilder sb = new StringBuilder();
            if (next.getName().equals("call-template")) {
                //1.得到节点->得到属性名称
                String name = next.attributeValue("name");
                sb.append(name).append("(");//trans_word_FUN(
                //2.得到子节点的迭代器，进行遍历
                Iterator<Element> subIterator = next.elementIterator();
                //如果迭代器为空
                if (!subIterator.hasNext()) {
                    sb.append(",");
                }
                while (subIterator.hasNext()) {
                    Element subNext = subIterator.next();
                    //3.再判断每个子节点中的子节点
                    if (subNext.getName().equals("with-param")) {

                        //如果有值就直接传进去
                        if (subNext.attributeValue("select") != null) {
                            String select = subNext.attributeValue("select");
                            sb.append(select).append(",");
                            continue;
                        }

                        //文本参数
                        if (subNext.element("text") != null) {
                            //trans_word_FUN('text',
                            Element textNode = subNext.element("text");
                            sb.append("'").append(textNode.getText()).append("'").append(",");
                        }
                        //传值参数
                        if (subNext.element("value-of") != null) {
                            //trans_word_FUN(MD@C,
                            //得到子节点及其属性内容
                            Element valueNode = subNext.element("value-of");
                            String select = valueNode.attributeValue("select");
                            //处理select,去掉分号
                            String[] split = select.split("/");
                            StringBuilder sumPath = new StringBuilder();
                            for (int i = 1; i < split.length; i++) {
                                sumPath.append(split[i]).append("|");
                            }
                            sumPath.deleteCharAt(sumPath.length() - 1);
                            sb.append(sumPath).append(",");
                        }
                    }
                }
                sb.deleteCharAt(sb.length() - 1);
                sb.append(")");
                String ftl = "${staticMethod." + sb + "}";
                writer.write(ftl);
                writer.flush();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public String getStrategyName() {
        return "funStrategy";
    }
}
