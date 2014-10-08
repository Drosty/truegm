module Admin
  class PlayerSalaryInformationController < BaseController

    def index
      @max_week = PlayerSalaryInformation.select(&:week).map(&:week).max
      @salaries = PlayerSalaryInformation.where(week: @max_week)
    end

    def new
    end

    def create
      week = params["week"].to_i

      if !week || week < 0 || week > 17
        redirect_to admin_salaries_path, alert: "File not processed.  Invalid Week"
      end

      file = params["salary_file"]
      file.open
      info = file.read

      data = CSV.parse(info, headers: true)

      PlayerSalaryInformation.where(week: week).delete_all

      data.each do |salary_data|
        if salary_data["Salary"].to_i > 0 && salary_data["Projection"].to_i > 0
          PlayerSalaryInformation.find_or_create_by(player_name: salary_data["Player"],
                                                    position: salary_data["Pos"],
                                                    salary: salary_data["Salary"],
                                                    week: week,
                                                    projection: salary_data["Projection"])
        end
      end

      redirect_to admin_salaries_path, alert: "File Import Processed"
    end

  end

end
