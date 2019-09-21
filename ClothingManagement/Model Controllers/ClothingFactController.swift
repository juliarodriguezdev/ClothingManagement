//
//  ClothingFactController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/20/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import Foundation

class ClothingFactController {
    
    static let shared = ClothingFactController()
    
    var clothingFacts: [ClothingFact] = []
    
    // instance
    
    // \"
    let f1 = ClothingFact(fact: "It takes 700 gallons of water to make a cotton shirt", source: "- Planetaid.org")
    let f2 = ClothingFact(fact: "Every year, more than 80 billion articles of clothing are produced and sold around the world.", source: "- Planetaid.org")
    let f3 = ClothingFact(fact: "...the amount of water needed to make a t-shirt is enough for one person to stay hydrated for 900 days while the amount of water needed to make a pair of jeans is equivalent to hosing down your lawn for 9 hours straight.", source: "- Planetaid.org")
    let f4 = ClothingFact(fact: "The average American throws out about 82 pounds of textile waste per year. That’s 11 million tons of waste produced every year by just the United States alone. ", source: "- Planetaid.org")
    let f5 = ClothingFact(fact: "Clothes can take up to 40 years to decompose.", source: "- Planetaid.org")
    let f6 = ClothingFact(fact: "In addition to releasing gases like methane, most fabrics are made with dyes and chemicals that can contaminate the soil and water in the ground. ", source: "- Planetaid.org")
    let f7 = ClothingFact(fact: "Shoes can take up to 1,000 years to break down.", source: "- Planetaid.org")
    let f8 = ClothingFact(fact: "Commonly made with a material called ethylene vinyl, the midsoles of shoes can take a really long time to break down.", source: "- Planetaid.org")
    let f9 = ClothingFact(fact: "95% of textiles can be recycled. Every year, we continue to throw away our old textiles, even though almost all of them can be recycled! This means that there is an alternative to landfill waste.", source: "- Planetaid.org")
    let f10 = ClothingFact(fact: "Textiles can be repurposed into a number of things, including sports fields, pillow stuffing, and paper money. ", source: "- Planetaid.org")
    let f11 = ClothingFact(fact: "Whether the textile fibers are turned into carpet padding, baseball filling or jewelry box lining, you never know where your recycled clothes might end up!", source: "- Planetaid.org")
    let f12 = ClothingFact(fact: "\"70% of the world wears secondhand clothing.\"", source: "- Planetaid.org")
    let f13 = ClothingFact(fact: "The Environmental Protection Agency estimates that the average person throws away 81 pounds of clothing per year.    That adds up to 3.8 billion pounds of unnecessary waste added to our landfills.", source: "- Smartasn.org")
    let f14 = ClothingFact(fact: "\"Recycling clothing and textiles decreases the use of natural resources, such as water used in growing crops and    petroleum used in creating new clothing and textiles. It also decreases the need for chemicals used in manufacturing new textiles and the pollution caused by the manufacturing process.\"", source: "- Smartasn.org")
    let f15 = ClothingFact(fact: "Since the mid 1940’s U.S. charities and the post-consumer textile recycling industry have repurposed and recycled billions of pounds of clothing, household textiles, shoes, and accessories. This ensures your old clothing, footwear, and textiles continue to add value to the U.S. economy and beyond.", source: "-Council for Textile Recycling")
    let f16 = ClothingFact(fact: "Nearly 70 million barrels of oil are used each year to make the world’s polyester fiber, which is now the most commonly used fiber in our clothing. But it takes more than 200 years to decompose.", source: "- Forbes.com")
    let f17 = ClothingFact(fact: "More than 150 billion garments are produced annually, enough to provide 20 new garments to every person on the planet, every year.", source: "- Forbes.com")
    let f18 = ClothingFact(fact: "Fast fashion garments, which we wear less than 5 times and keep for 35 days, produce over 400% more carbon emissions per item per year than garments worn 50 times and kept for a full year.", source: "- Forbes.com")
    let f19 = ClothingFact(fact: "Cheap synthetic fibers also emit gasses like N2O, which is 300 times more damaging than CO2.", source: "- Forbes.com")
    let f20 = ClothingFact(fact: "Over 70 million trees are logged every year and turned into fabrics like rayon, viscose, modal and lyocell.", source: "- Forbes.com")
    let f21 = ClothingFact(fact: "Cotton is the world’s single largest pesticide-consuming crop, using 24% of all insecticides and 11% of all pesticides globally, adversely affecting soil and water.", source: "- Forbes.com")
    let f22 = ClothingFact(fact: "Plastic microfibers shed from our synthetic clothing into the water supply account for 85% of the human-made material found along ocean shores, threatening marine wildlife and ending up in our food supply.", source: "- Forbes.com")
    let f23 = ClothingFact(fact: "The fashion industry is the second biggest polluter of freshwater resources on the planet.", source: "- Forbes.com")
    let f24 = ClothingFact(fact: "The apparel industry accounts for 10% of global carbon emissions and remains the second largest industrial polluter, second only to oil.", source: "- Forbes.com")
    let f25 = ClothingFact(fact: "More than 15 million tons of used textile waste is generated each year in the United States, and the amount has doubled over the last 20 years.", source: "- Thebalancesmb.com")
    let f26 = ClothingFact(fact: "Consumers are regarded as the main culprit for throwing away their used clothing, as only 15 percent of consumer-used clothing is recycled, whereas more than 75 percent of pre-use clothing is recycled by the manufacturers.", source: "- Thebalancesmb.com")
    let f27 = ClothingFact(fact: "The average person buys 60 percent more items of clothing every year and keeps them for about half as long as 15 years ago, generating a huge amount of waste. ", source: "- Thebalancesmb.com")
    let f28 = ClothingFact(fact: "The annual environmental impact of a household’s clothing is equivalent to the water needed to fill 1,000 bathtubs and the carbon emissions from driving an average modern car for 6,000 miles", source: "- Thebalancesmb.com")
    let f29 = ClothingFact(fact: "If the average life of clothing was extended by just three months, it would reduce their carbon and water footprints, as well as waste generation, by five to 10 percent. The recycling of two million tons of clothing per year equates to taking one million cars from U.S. streets. ", source: "- Thebalancesmb.com")
    let f30 = ClothingFact(fact: "More than 70 percent of the world's population uses secondhand clothing. About 50 percent of collected shoes and clothing is used as secondhand products. Meanwhile, 20 percent is used to produce polishing and cleaning cloths for various industrial purposes, and 26 percent is recycled for applications such as fiber for insulation products, upholstery, fiberboard, and mattresses.  ", source: "- Thebalancesmb.com")
    let f31 = ClothingFact(fact: "The United States textile recycling industry removes approximately 2.5 billion pounds of post-consumer textiles each year from the waste stream, and the industry creates more than 17,000 jobs. Among this workforce, 10,000 are semi-skilled workers employed in the primary processing of used textile; the remaining 7,000 employees are employed in the final processing stage. There are more than 500 garment-recycling companies in the U.S. and a majority of these companies are owned and operated by small and family businesses, each of which employs 35 to 50 workers. ", source: "- Thebalancesmb.com")
    let f32 = ClothingFact(fact: "Meanwhile, synthetic fibers, like polyester, nylon and acrylic, have the same environmental drawbacks, and because they are essentially a type of plastic made from petroleum, they will take hundreds of years, if not a thousand, to biodegrade.", source: "- Newsweek.com")
    let f33 = ClothingFact(fact: "It can take up to 200 tons of fresh water per ton of dyed fabric.  ", source: "- Sustainyourstyle.org")
    let f34 = ClothingFact(fact: "Up to 20,000 liters of water are needed to produce just 1kg of cotton.", source: "- Sustainyourstyle.org")
    let f35 = ClothingFact(fact: "In most of the countries in which garments are produced, untreated toxic wastewaters from textiles factories are dumped directly into the rivers.", source: "- Sustainyourstyle.org")
    let f36 = ClothingFact(fact: "Wastewater contains toxic substances such as lead, mercury, and arsenic, among others. These are extremely harmful for the aquatic life and the health of the millions people living by those rivers banks. The contamination also reaches the sea and eventually spreads around the globe. ", source: "- Sustainyourstyle.org")
    let f37 = ClothingFact(fact: "20% of industrial water pollution comes form textiles treatment and dying", source: "- Sustainyourstyle.org")
    let f38 = ClothingFact(fact: "20,000 tons of dyes are lost to effluents every year.", source: "- Sustainyourstyle.org")
    let f39 = ClothingFact(fact: "90% of wastewaters in developing countries is discharged into rivers without treatment", source: "- Sustainyourstyle.org")
    let f40 = ClothingFact(fact: "The fashion industry is a major water consumer.Huge quantity of fresh water are used for the dyeing and finishing process for all of our clothes.", source: "- Sustainyourstyle.org")
    let f41 = ClothingFact(fact: "200 tons of fresh water are needed to dye one ton of fabric", source: "- Sustainyourstyle.org")
    let f42 = ClothingFact(fact: "Every time we wash a synthetic garment (polyester,nylon, etc), about 1,900 individual microfibers are released into the water, making their way into our oceans.", source: "- Sustainyourstyle.org")
    let f43 = ClothingFact(fact: "Scientists have discovered that small aquatic organisms ingest those microfibers. These are then eaten by small fish which are later eaten by bigger fish, introducing plastic in our food chain.", source: "- Sustainyourstyle.org")
    let f44 = ClothingFact(fact: "85% of human-made debris on the shorelines around the world are microfibers", source: "- Sustainyourstyle.org")
    let f45 = ClothingFact(fact: "190,000 tons of textile microplastic fibers end up in the oceans every year", source: "- Sustainyourstyle.org")
    let f46 = ClothingFact(fact: "Twice as many particles are released by older garments compared to new ones", source: "- Sustainyourstyle.org")
    let f47 = ClothingFact(fact: "Synthetic fibers, such as polyester, are plastic fibers, therefore non-biodegradable and can take up to 200 years to decompose. Synthetic fibers are used in 72% of our clothing.", source: "- Sustainyourstyle.org")
    let f48 = ClothingFact(fact: "3 years is the average liftime of a garment today", source: "- Sustainyourstyle.org")
    let f49 = ClothingFact(fact: "The heavy use of chemicals in cotton farming is causing diseases and premature death among cotton farmers, along with massive freshwater and ocean water pollution and soil degradation.", source: "- Sustainyourstyle.org")
    let f50 = ClothingFact(fact: "1 Kg of chemicals is needed to produce 1 Kg of textiles", source: "- Sustainyourstyle.org")
    let f51 = ClothingFact(fact: "23% of all chemicals produced worldwide are used for the textile industry", source: "- Sustainyourstyle.org")
    let f52 = ClothingFact(fact: "27% of the weight of a \"100% natural\" fabric is made of chemicals", source: "- Sustainyourstyle.org")
    let f53 = ClothingFact(fact: "Synthetic fibers (polyester, acrylic, nylon, etc.), used in the majority of our clothes, are made from fossil fuel, making production much more energy-intensive than with natural fibers.", source: "- Sustainyourstyle.org")
    let f54 = ClothingFact(fact: "Most of our clothes are produced in China, Bangladesh, or India, countries essentially powered by coal. This is the dirtiest type of energy in terms of carbon emissions.  ", source: "- Sustainyourstyle.org")
    let f55 = ClothingFact(fact: "Cheap synthetic fibers also emit gases like N2O, which is 300 times more damaging than CO2.", source: "- Forbes.com")
    let f56 = ClothingFact(fact: "23 kG of greenhouse gases are generated for each kilo of fabric produced", source: "- Sustainyourstyle.org")
    let f57 = ClothingFact(fact: "70 million oil barrels are used each year to produce polyester", source: "- Sustainyourstyle.org")
    let f58 = ClothingFact(fact: "400% more carbon emissions are produced if we wear a garment 5 times instead of 50 time", source: "- Sustainyourstyle.org")
    let f59 = ClothingFact(fact: "The fashion industry plays a major part in degrading soil in different ways: overgrazing of pastures through cashmere goats and sheep raised for their wool; degradation of the soil due to massive use of chemicals to grow cotton; deforestation caused by wood-based fibers like rayon.", source: "- Sustainyourstyle.org")
    let f60 = ClothingFact(fact: "70 millions trees are cut down each year to make our clothes", source: "- Sustainyourstyle.org")
    let f61 = ClothingFact(fact: "30% of rayn and viscose clothing comes from endangered and ancient forests", source: "- Sustainyourstyle.org")
    let f62 = ClothingFact(fact: "5% of the global apparel industry uses forest based products", source: "- Sustainyourstyle.org")
    let f63 = ClothingFact(fact: "According to a World Bank estimate, almost 20% of global industrial water pollution comes from the treatment and dyeing of textiles.", source: "- Fabricoftheworld.com")
    let f64 = ClothingFact(fact: "About 72 toxic chemicals reach our water supply from textile dyeing, many of which cannot be filtered or removed.", source: "- Fabricoftheworld.com")
    let f65 = ClothingFact(fact: "Wastewater discharged by the textile industry contains chemicals such as formaldehyde (HCHO), chlorine and heavy metals such as lead and mercury.", source: "- Fabricoftheworld.com")
    let f66 = ClothingFact(fact: "Landfills contain minimal amounts of oxygen and moisture, so they are not designed to breakdown trash, but to bury it.", source: "- Fabricoftheworld.com")
    let f67 = ClothingFact(fact: "In North America alone, consumers are buying and discarding five times as much clothing as they did 25 years ago. About 85% of this ends up in landfills.", source: "- Fabricoftheworld.com")
    let f68 = ClothingFact(fact: "Textile waste forms leachate as it decomposes, often contaminating groundwater through leakage.", source: "- Fabricoftheworld.com")
    let f69 = ClothingFact(fact: "The decomposition of organic fibres and yarn such as wool produces large amounts of ammonia and methane. Ammonia is highly toxic in both terrestrial and aquatic environments, and can be toxic in gaseous form. Methane, if uncollected, significantly impacts global warming.", source: "- Fabricoftheworld.com")
    let f70 = ClothingFact(fact: "Further, in landfills where textile waste is incinerated in large quantities, harmful substances such as dioxins, heavy metals, acidic gases and dust particles are emitted.", source: "- Fabricoftheworld.com")
    let f71 = ClothingFact(fact: "Today. more than 70 per cent of the world’s population uses second-hand clothing.", source: "- Fabricoftheworld.com")
    let f72 = ClothingFact(fact: "While natural cotton fibre is completely biodegradable, it can take over 20,000 litres of water to produce cotton for a single T-shirt and pair of jeans. 2.4% of the world’s crop land is planted with cotton and yet it accounts for 24% and 11% of the global sales of insecticide and pesticides respectively.", source: "- Fabricoftheworld.com")
    let f73 = ClothingFact(fact: "On the other hand, polyester fibre is made from petroleum, a non-renewable resource that creates damaging environmental impacts during the extraction process. However, in the whole lifecycle of the fibre, from the raw materials, through the use phase to the end of the lifecycle, polyester has lower energy impacts during the washing and cleaning phase and is also completely recyclable at the end of its life.", source: "- Fabricoftheworld.com")
    let f74 = ClothingFact(fact: "Globally, 80% of discarded textiles are doomed for the landfill or incineration. Only 20% are actually reused or recycled.", source: "- Remake.world")
    let f75 = ClothingFact(fact: "The clothing that ends up in landfills can sit there for 200-plus years, and as it decomposes, it emits methane—a greenhouse gas more potent than carbon.", source: "- Remake.world")
    let f76 = ClothingFact(fact: "The U.S. alone sends about 21 billion pounds of textile waste to landfills every year. ", source: "- Remake.world")
    let f77 = ClothingFact(fact: "Goods that were not recycled or reused translate into about an $88 billion loss. That’s due to a loss in value and resources that went into making them.", source: "- HuffPost.com")
    let f78 = ClothingFact(fact: "On the other hand, contributing to the secondhand industry, helps to infuse money into the economy. The industry employs nearly 100,000 workers and creates $1 billion in wages in the U.S. alone.", source: "- HuffPost.com")
    let f79 = ClothingFact(fact: "By extending the life cycle of secondhand clothing, the reuse industry employs nearly 100,000 workers and create $1 billion in wages in the U.S. alone.", source: "- HuffPost.com")
    
    func loadClothingFacts() {
        clothingFacts = [f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79]
    }
    
}
