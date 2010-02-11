class Datum

  FIELDS = %w(ndb_id short_description water food_energy protein total_lipids ash carbohydrates
              total_dietary_fiber total_sugars calcium iron magnesium phosphorus potassium sodium
              zinc copper manganese selenium vitamin_c thiamin riboflavin niacin pantothenic_acid
              vitamin_b6 total_folate folic_acid food_folate folate total_choline vitamin_b12
              vitamin_a vitamin_a_rae retinol alpha_carotene beta_carotene beta_cryptoxanthin
              lycopene lutein_plus_zeazanthin vitamin_e vitamin_k saturated_fatty_acid
              monounsaturated_fatty_acids polyunsaturated_fatty_acids cholesterol weight_1
              weight_1_description weight_2 weight_2_description percent_refuse)

  attr_accessor( *FIELDS )

end
