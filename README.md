# MATH435 Math in the City
## Patient Zero Vaccination Strategy

The following project is a mathematical model that describes a hypothetical vaccination strategy called **Patient Zero**, whereby instead of having a traditional model of vaccination, we introduce an infected patient with a strain of virus that competes with the existing strain with a higher infection rate but a with a lower death rate. <br>

We would compare the outcomes of the two models and evaluate the costs associated with each strategy.

## Project Outline
1. **Baseline Model** <br>
This is based on Dr. Glenn Ledder's Model of Covid-19. The model starts with the initial distribution of vaccines and its outcomes such as hospitailization, number of infections and deaths etc. This would serve as our baseline model as it represents the *traditional* model of vaccination. Note that even though this is a Covid-19 model, we are treating it as a traditional model of vaccination for a given pandemic with similar characteristics of that of the current pandemic as of writing. <br>

We also included code in estimating parameters for the model.n

2. **Patient Zero Model** <br>
This model assumes that we have a hypothetical technology that allows us to create a more infectious strain of the virus but with less severe symptoms, and as a result lower hospitalization and death rate. This virus would take over as a dominant strain, effectively conferring immunity to those who are infected from the original more deadly strain of virus.

3. **Comparison of Outcomes** <br>
Using different parameters of the models, we would then simulate the outcomes of both models to compare and contrast the final outcome in terms of death rates, hospitalization rates and length of pandemic that with the two different strategies.


### 01 COVID19 Ledder
This is the **SEAIHRD** Epidemic Model developed by Dr. Glenn Ledder to study the Covid19 epidemic in the initial rollout of vaccination and the onset of the Delta Variant. Our baseline model is going to be largely based on the following code.

### 02 Normal vaccination
This is Vaccination Model that we developed that complements the Patient Zero Vaccination Model, with realistic distribution of vaccination and the resulting outcomes such as deaths, hospitalization etc.

### 03 Patient 0
This is the Patient Zero vaccination model as described in the paper Patient_Zero.pdf
