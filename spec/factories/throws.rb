FactoryBot.define do
  factory :throw do
    number_of_knocked_down_pins { 1 }
    is_strike { false }
    is_spare { false }
  end
end
