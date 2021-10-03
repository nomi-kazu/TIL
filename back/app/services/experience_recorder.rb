class ExperienceRecorder

  def initialize(user)
    @user = user
  end

  def record(post)
    hours,minutes = post.study_time.split(':')
    experience = hour * 60 + minutes

    experience_record = @user.experience_records.build(
      obtained_exp: experience,
      post_id: post.id
    )
    if experience_record.save
      experience_record
    end
  end
end