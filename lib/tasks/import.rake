# namespace :import do
#   desc "TODO"
#   task user_data: :environment do
#   end
#
# end
namespace :import do
  desc 'Uploads data from xlsx'

  task :user_data, [:xlsx_path] => :environment do |_t, args|
    expenses_controller = ExpensesController.new
    expenses_controller.import_data(xlsx_path: args[:xlsx_path])
  end
end
