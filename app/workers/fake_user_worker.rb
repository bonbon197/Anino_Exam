class FakeUserWorker
    include Sidekiq::Worker
  
    def perform(leaderboard_id, current_first_place_user_id)
      leaderboard = Leaderboard.find(leaderboard_id)
      return unless leaderboard.present?
  
      fake_user = User.find_or_create_by(name: 'Fake User')
      
      entry = Entry.find_or_initialize_by(user_id: fake_user.id, leaderboard_id: leaderboard.id)
      entry.score ||= 0
      entry.score += 10
      entry.save!
  
      new_first_place_user = leaderboard.entries.order(score: :desc).first.user
  
      # If the fake user has overtaken the first place, stop scheduling this job
      if new_first_place_user.id == fake_user.id
        return
      end
  
      # Schedule the job to run again in 5 seconds if the fake user hasn't overtaken the first place
      self.class.perform_in(5.seconds, leaderboard_id, current_first_place_user_id)
    end
  end
  