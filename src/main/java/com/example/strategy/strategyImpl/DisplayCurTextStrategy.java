package com.example.strategy.strategyImpl;

import com.example.strategy.Strategy;
import org.dom4j.Element;
import org.springframework.stereotype.Component;

import java.io.Writer;

@Component
public class DisplayCurTextStrategy implements Strategy {

    @Override
    public void doOperation(Element next, Writer writer) {
        try {
            if (next.getName().equals("call-template") && (next.attributeValue("name").equals("display_cur_text"))) {
                if (next.element("with-param") != null) {
                    if (next.element("with-param").element("call-template") != null) {
                        Element callTemplate = next.element("with-param").element("call-template");
                        FunStrategy funStrategy = new FunStrategy();
                        funStrategy.doOperation(callTemplate, writer);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public String getStrategyName() {
        return "displayCurTextStrategy";
    }
}
