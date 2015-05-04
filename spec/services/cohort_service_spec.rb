require 'rails_helper'

describe CohortService do

  context 'take_daily_measurement' do
    let(:group) { create :group, cohort_id: 1 }
    let(:today) { Date.today }

    before do
      group
      CohortService.take_daily_measurement
    end

    it "creates a snapshot for a group in a cohort" do
      measurement = GroupMeasurement.last
      measurement.group_id.should == group.id
      measurement.measured_on.should == today
    end
  end
end
