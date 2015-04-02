

RERUN_FILE = File.expand_path('../../rerun.txt', __FILE__)
PHOENIX_FILE =  File.expand_path('../../features/phoenix_smoke_test.feature', __FILE__)

def get_rerun_cases()
  result_file = File.open(RERUN_FILE,'r')
  result = result_file.readlines()[0]

  phoenix_case_file = File.open(PHOENIX_FILE,'r')
  feature_lines = phoenix_case_file.readlines()
  puts feature_lines[0]

  rerun_cases = []

  failed_cases_lines = result.match(/\d+(:\d+)*/)[0].split(':')

  failed_cases_lines.each_index { |k|
    scenario = feature_lines[ failed_cases_lines[k].to_i - 1 ]

    # get precondition cases of failed cases
    precondition_cases = []
    if scenario.match(/Precondition:\S*$/) != nil
      preconditions = scenario[/Precondition:\S*$/].gsub(/Precondition:/,'')
      precondition_cases = preconditions.split(',')
      precondition_cases.each { |case_number| rerun_cases << case_number unless rerun_cases.include?(case_number)}
    end
    # add failed cases
    failed_case = scenario[/Scenario:\D*\d+/].gsub(/Scenario:\D*/,'@TC.')
    rerun_cases << failed_case unless rerun_cases.include?(failed_case)
  }

  rerun_cases.join(',')

end

