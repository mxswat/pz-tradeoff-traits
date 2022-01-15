ProfessionFramework.addTrait('BritishFoodFan', {
    icon = "trait_BritishFoodFan",
    name = "UI_trait_BritishFoodFan",
    description = "UI_trait_BritishFoodFan_desc",
    exclude = { "ItalianFoodEnjoyer" },
    cost = 1,
})

ProfessionFramework.addTrait('ItalianFoodEnjoyer', {
    icon = "trait_ItalianFoodEnjoyer",
    name = "UI_trait_ItalianFoodEnjoyer",
    description = "UI_trait_ItalianFoodEnjoyer_desc",
    -- exclude = { "BritishFoodFan" },
    cost = -1,
})

-- This is just like a Payday2 `old_hook`, very nice
local ISEatFoodAction_perform = ISEatFoodAction.perform;
function ISEatFoodAction:perform()
    local player = getPlayer();
    local isBritishFoodFan = player:HasTrait("BritishFoodFan");
    
    -- Unhappines is a positive number eg: dog food has 50
    -- Icecream cone give happines so the value is negative in this case is -10
    local unhappiness = self.item:getUnhappyChange()
    print("Current unhappiness: "..unhappiness)

    if isBritishFoodFan then
        -- -80% on all food happines/sadness effects
        self.item:setUnhappyChange(unhappiness * 0.20)
    end
    
    local isItalianFoodEnjoyer = player:HasTrait("ItalianFoodEnjoyer");
    if isItalianFoodEnjoyer then 
        -- On conumption of food +100% Increase happiness on food with positive happiness
        -- +50% Increase sadness on food with negative happiness
        -- +5 happiness on cooked pasta maybe implement this?
        local new_unhappiness = unhappiness < 0 and unhappiness * 2 or unhappiness * 1.5
        self.item:setUnhappyChange(new_unhappiness)
    end

    print("Trait unhappiness: "..self.item:getUnhappyChange())

    ISEatFoodAction_perform(self);
end