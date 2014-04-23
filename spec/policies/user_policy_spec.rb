require 'spec_helper'

describe UserPolicy do

  describe "Admin User" do
    let(:user) do
      build(:user, :admin)
    end

  end

end
