module Gloves
  module Feedback
    def open(opennable)
      `open #{opennable}`
    end

    def clipboard(string)
      IO.popen('pbcopy', 'w') { |f| f << string }
    end

    def notify(options)
      `osascript -e 'display notification "#{options[:body]}" with title "#{options[:title]}"'`
    end
  end
end
