require 'calabash'

Before do |scenario|
  if scenario.respond_to?(:scenario_outline)
    scenario = scenario.scenario_outline
  end

  reset_between_scenarios(scenario) do
    cal.ensure_app_installed
    cal.clear_app_data
    cal.start_app
  end
end

After do
  cal.stop_app
end

def reset_between_scenarios(scenario, &block)
  block.call
end

def reset_between_features(scenario, &block)
  if scenario.feature != @last_feature
    block.call
  end

  @last_feature = scenario.feature
end
