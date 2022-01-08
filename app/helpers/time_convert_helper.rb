require 'date'

module TimeConvertHelper
    def epoch_2_regular(time) #convert epoch time to regular time
        return Time.at(time)
    end

    def regular_2_epoch(time)
        return DateTime.parse(time).to_time.to_i
    end
end