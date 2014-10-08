class SalaryLineup < ActiveRecord::Base
  attr_accessible :qbname, :qbsalary, :qbprojection, :rb1name,
                  :rb1salary, :rb1projection, :rb2name, :rb2salary,
                  :rb2projection, :wr1name, :wr1salary, :wr1projection,
                  :wr2name, :wr2salary, :wr2projection, :wr3name,
                  :wr3salary, :wr3projection, :te1name, :te1salary,
                  :te1projection, :kname, :ksalary, :kprojection,
                  :dstname, :dstsalary, :dstprojection, :total_salary,
                  :total_projection
end
