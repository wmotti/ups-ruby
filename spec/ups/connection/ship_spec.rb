current_directory = File.dirname(File.absolute_path(__FILE__))
Dir.glob("#{current_directory}/ship/*.rb") { |test_file| require test_file }
