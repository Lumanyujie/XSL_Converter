package com.example.strategy.strategyImpl;

import com.example.strategy.Strategy;
import org.dom4j.Element;
import org.springframework.stereotype.Component;

import java.io.Writer;
import java.util.Iterator;

/**
 * 解析列转换
 */
@Component
public class ParseColStrategy implements Strategy {
    @Override
    public void doOperation(Element next, Writer writer) {
        try {
            if ((next.getName().equals("call-template")) && (next.attributeValue("name").equals("parse-col"))) {
                Iterator<Element> subIterator = next.elementIterator();
                String parseCol = "";
                while (subIterator.hasNext()) {
                    Element subNext = subIterator.next();
                    if (subNext.getName().equals("with-param")) {
                        if (subNext.attributeValue("name").equals("target-string")) {
                            parseCol = parseCol + subNext.getText();
                        }

                        if (subNext.attributeValue("name").equals("is-begin-with-slide")) {
                            if (subNext.getText().equals("0")) {
                                writer.write(parseCol);
                                writer.flush();
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public String getStrategyName() {
        return "parseColStrategy";
    }
}
