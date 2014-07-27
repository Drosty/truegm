module Import
  class BaseImport

    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name.gsub(/\s+/, "")}=", value)
      end
    end

  end
end
