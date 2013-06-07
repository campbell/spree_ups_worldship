module Spree
	class Calculator
		
		module Ups

			SERVICE_CODES = {
				NextDayAirEarlyAm => '1DM',
				NextDayAir => '1DA',
				NextDayAirSaver => '1DP',
				SecondDayAir => '2DA',
				ThreeDaySelect => '3DS',
				Ground => 'GND',
				Express => 'ES',
				Saver => 'SV',
				WorldwideExpedited => 'EX',
				Standard => 'ST'
			}

			SERVICE_CODES.keys.each do |klass|
				klass.class_eval do
					def service_code
						SERVICE_CODES[self.class]
					end
				end
			end

		end
	end
end
