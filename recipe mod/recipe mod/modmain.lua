PrefabFiles = {
    "sooty",
    "birdy",
}

	
   Assets = 
{
	
    Asset("ATLAS", "images/inventoryimages/sooty.xml"),
    Asset("ATLAS", "images/inventoryimages/birdy.xml"),

}
 

        STRINGS = GLOBAL.STRINGS
        RECIPETABS = GLOBAL.RECIPETABS
        Recipe = GLOBAL.Recipe
        Ingredient = GLOBAL.Ingredient
        TECH = GLOBAL.TECH





        -- sooty Info
        GLOBAL.STRINGS.NAMES.SOOTY = "sooty"
        STRINGS.RECIPE_DESC.SOOTY = "he will keep us safe at night"
        GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.SOOTY = "monkeys favrout teddy"


        -- birdy info
        GLOBAL.STRINGS.NAMES.BIRDY = "birdy"
        STRINGS.RECIPE_DESC.BIRDY = "birdy!!! tweet tweet tweet"
        GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.BIRDY = "birdy!!!! tweet tweet tweet birdy!!!"



        -- sooty Recipe
        local sooty = GLOBAL.Recipe("sooty",{ Ingredient("beefalowool", 10), Ingredient("redgem", 2), Ingredient("reviver", 1) },GLOBAL.RECIPETABS.MAGIC, GLOBAL.TECH.NONE, nil, nil, nil, nil, nil, "images/inventoryimages/sooty.xml", "sooty.tex" )
        sooty.atlas = "images/inventoryimages/sooty.xml"

        -- birdy recipe
        local birdy = GLOBAL.Recipe("birdy",{ Ingredient("feather_robin", 10), Ingredient("bluegem", 2), Ingredient("reviver", 1) },GLOBAL.RECIPETABS.MAGIC, GLOBAL.TECH.NONE, nil, nil, nil, nil, nil, "images/inventoryimages/birdy.xml", "birdy.tex" )
        birdy.atlas = "images/inventoryimages/birdy.xml"




