package com.example.strategy;

import org.dom4j.Element;
import org.springframework.stereotype.Service;

import java.io.Writer;

@Service
public interface Strategy {
    void doOperation(Element next, Writer writer);
    String getStrategyName();
}
