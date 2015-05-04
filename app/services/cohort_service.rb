class CohortService
  def self.take_daily_measurement
    today = Date.today

    Group.in_any_cohort.each do |group|
      GroupMeasurement.create do |gm|
        gm.group_id = group.id
        gm.measured_on = today
        gm.members_count = group.members.count
        gm.invitations_count = group.invitations.count
        gm.discussions_count = group.discussions.count
        gm.proposals_count = group.motions.count
        gm.comments_count = group.comments.count
        gm.likes_count = group.comment_votes.count
      end
    end
  end
end
