package com.example.factory;

import com.example.strategy.Strategy;
import com.example.strategy.strategyImpl.DisplayCurTextStrategy;
import com.example.strategy.strategyImpl.FunStrategy;
import com.example.strategy.strategyImpl.ParseColStrategy;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Component
public class StrategyFactory implements Factory {
    //用map来存放策略名和策略
    private static Map<String, Strategy> strategyMap = new ConcurrentHashMap<>();

    /**
     * 注册策略
     */
    static {
        strategyMap.put("funStrategy", new FunStrategy());
        strategyMap.put("parseColStrategy", new ParseColStrategy());
        strategyMap.put("displayCurTextStrategy", new DisplayCurTextStrategy());
    }

    @Override
    public Strategy createStrategy(String strategyName) {
        return strategyMap.get(strategyName);
    }

    @Override
    public void registerStrategy(Strategy strategy) {
        strategyMap.put(strategy.getStrategyName(), strategy);
    }
}
