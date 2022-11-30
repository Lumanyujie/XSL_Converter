package com.example.register;

import com.example.factory.Factory;
import com.example.strategy.Strategy;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Component;

import java.util.Iterator;
import java.util.Map;
import java.util.Set;

@Component
public class StartAction implements ApplicationListener<ContextRefreshedEvent> {
    @Autowired
    private Factory factory;

    @Override
    public void onApplicationEvent(ContextRefreshedEvent event)
    {
        Map<String, Strategy> map = event.getApplicationContext()
                .getBeansOfType(Strategy.class);
        Set<String> keySet = map.keySet();
        Iterator<String> iterator = keySet.iterator();
        while (iterator.hasNext())
        {
            String key = iterator.next();
            Strategy strategy = map.get(key);
            factory.registerStrategy(strategy);
        }
    }
}
