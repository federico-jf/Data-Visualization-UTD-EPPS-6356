library(tidyverse)
library(gapminder)
gm = gapminder
head(gm)
summary(gm)
table(gm$country)

# Plot one variable
hist(gm$lifeExp)
# Plot two variables with logged version of x
plot(lifeExp ~ gdpPercap, gm, subset = year == 2007, log = "x", pch=20)
library(ggplot2)
p <- ggplot(data = gm)
p

p <- ggplot(data = gm,
            mapping = aes(x = gdpPercap,y = lifeExp))
p + geom_point(size=2)


p <- ggplot(data = gm,
            
            mapping = aes(x = gdpPercap,
                          
                          y = lifeExp))


p + geom_point(color = "forestgreen") +
  
  geom_smooth(method = "loess") +
  
  
  scale_x_log10()

p <- ggplot(data = gm,
            
            mapping = aes(x = gdpPercap,
                          
                          y = lifeExp))

p + geom_point(color = "purple") +
  
  
  geom_smooth(method = "loess") + scale_x_log10() +
  
  
  xlab("GDP per capita") +
  
  
  ylab("Life Expectancy") +
  
  
  facet_wrap(~ continent, nrow=2)



p <- ggplot(data = gm,
            mapping = aes(x = gdpPercap,
                          y = lifeExp))
p + geom_point(color = "purple") +
  geom_smooth(method = "loess") + scale_x_log10() +
  xlab("GDP per capita") +
  ylab("Life Expectancy") +
  facet_wrap(~ continent, nrow=2) +
  theme(text=element_text(size=14, family="Palatino"))

p <- ggplot(data = gm,
            mapping = aes(x = gdpPercap,
                          y = lifeExp))
p + geom_point(color = "purple") +
  geom_smooth(method = "loess") + scale_x_log10() +
  xlab("GDP per capita") +
  ylab("Life Expectancy") +
  facet_wrap(~ continent, nrow=2) +
  theme_bw()+
  theme(text=element_text(size=14, family="Palatino"))
  
