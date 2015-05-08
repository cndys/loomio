class CohortService
  def self.take_daily_measurement
    
    ActiveRecord::Base.connection.execute "
    WITH counts AS (
      SELECT 
      id as group_id,
        current_date as measured_on,
        (SELECT COUNT(memberships.id) FROM memberships WHERE group_id = groups.id AND archived_at IS NULL and is_suspended = false) AS members_count,
        (SELECT COUNT(invitations.id) FROM invitations WHERE invitable_type = 'Group' and invitable_id = groups.id) AS invitations_count,
        (SELECT COUNT(discussions.id) FROM discussions WHERE group_id = groups.id) AS discussions_count,
        (SELECT COUNT(motions.id) FROM motions JOIN discussions ON motions.discussion_id = discussions.id WHERE discussions.group_id = groups.id) AS proposals_count,
        (SELECT COUNT(comments.id) FROM comments JOIN discussions ON comments.discussion_id = discussions.id WHERE discussions.group_id = groups.id) AS comments_count,
        (SELECT COUNT(comment_votes.id) FROM comment_votes JOIN comments ON comment_votes.comment_id = comments.id JOIN discussions ON comments.discussion_id = discussions.id WHERE discussions.group_id = groups.id ) as likes_count
      FROM groups ORDER by id ASC
    ) INSERT INTO group_measurements (group_id, measured_on, members_count, invitations_count, discussions_count, proposals_count, comments_count, likes_count) SELECT group_id, measured_on, members_count, invitations_count, discussions_count, proposals_count, comments_count, likes_count FROM counts;
    "
    
  end
end
