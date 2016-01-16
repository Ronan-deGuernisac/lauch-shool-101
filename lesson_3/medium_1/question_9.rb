# question_9.rb

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.each do |munster, munster_hash|
  case munster_hash["age"]
  when 0..17 then munster_hash.store("age_group", "kid")
  when 18..64 then munster_hash.store("age_group", "adult" ) 
  else munster_hash.store("age_group", "senior")
  end
end
