class ExperienceRecorder

  def initialize(user)
    @user = user
  end

  def record(post)
    hours = time_report.study_time.hour
    minutes = time_report.study_time.min
    experience = hours * 60 + minutes

    experience_record = @user.experience_records.build(
      obtained_exp: experience,
      post_id: post.id
    )
    if experience_record.save!
      experience_record
    end
  end
end