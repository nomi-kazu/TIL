class ExperienceRecorder

  def initialize(user)
    @user = user
  end

  def record(post)
    hours = post.study_time.hour
    minutes = post.study_time.min
    gain_exp = hours * 60 + minutes

    experience_record = @user.experience_records.build(
      obtained_exp: gain_exp,
      post_id: post.id
    )
    if experience_record.save!
      @user.experience.lifelong_exp += gain_exp
      check_level(gain_exp)
      @user.experience.save!
      experience_record
    end
  end

  private

  def check_level(gain_exp)
    to_next = @user.experience.experience_to_next
    to_next -= gain_exp
    if to_next <= 0
      next_level = RequiredExp.find_by(level: @user.experience.level + 1)
      sub_next = next_level.required_exp - (- to_next)
      level_up(sub_next)
    end
  end

  def level_up(sub_next)
    if sub_next > 0
      @user.experience.level += 1
      @user.experience.experience_to_next = sub_next
    else
      @user.experience.level += 1
      level_up(- sub_next)
    end
  end
end