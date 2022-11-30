package com.example.strategy.strategyImpl;

import com.example.strategy.Strategy;
import org.dom4j.Element;
import org.springframework.stereotype.Component;

import java.io.Writer;

@Component
public class ProcessBrStrategy implements Strategy {
    @Override
    public void doOperation(Element next, Writer writer) {
        try {
            if (next.attributeValue("name") != null) {
                if (next.attributeValue("name").equals("process-br")) {
                    writer.write("\\n");
                    writer.flush();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @Override
    public String getStrategyName() {
        return "processBrStrategy";
    }
}
