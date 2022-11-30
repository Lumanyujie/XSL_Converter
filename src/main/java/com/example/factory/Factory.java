package com.example.factory;

import com.example.strategy.Strategy;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

@Service
public interface Factory {
    Strategy createStrategy(String strategyName);
    void registerStrategy(Strategy strategy);
}
